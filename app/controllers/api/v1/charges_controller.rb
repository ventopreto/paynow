class Api::V1::ChargesController < ActionController::API

  def index
    
    if charge_params[:payment_category]  && charge_params[:payment_category]  != ""
    @charges = Charge.where(payment_category: charge_params[:payment_category])
    elsif  charge_params[:billing_due_date] && charge_params[:billing_due_date]  != ""
      @charges = Charge.where(billing_due_date: charge_params[:billing_due_date])
    else 
      params.fetch(:payment_category)  || params.fetch(:billing_due_date)
    end
    if @charges != []
    render json:@charges.as_json(except: [:id, :created_at, :updated_at]), status: 200
    else
      head 404
    end
  rescue ActionController::ParameterMissing
      render status: 412, json:{errors: 'Parâmetros inválidos'}
  end

  def create
    @company = Company.find_by(token: charge_params[:company_token])
    @product = Product.find_by(token: charge_params[:product_token])
    @end_user = EndUser.find_by(token: charge_params[:end_user_token])
    case charge_params[:payment_category]
    when 'boleto'
      @discount = @product.price - @product.price*10/100
      @boleto = Boleto.find(charge_params[:payment])
      @address = charge_params[:address]
      @charge = Charge.create!(company: @company, end_user:@end_user, product: @product,
      boleto:@boleto, original_value: @product.price, payment_method: @boleto.payment_method, 
      payment_category: charge_params[:payment_category], address:@address, 
      value_with_discount: @discount, billing_due_date: 3.days.from_now.strftime("%d/%m/%Y") )           
    when 'pix'
      @discount = @product.price - @product.price*5/100
      @pix = Pix.find(charge_params[:payment])
      @charge = Charge.create!(company: @company, end_user:@end_user, product: @product,
      pix:@pix, original_value: @product.price, payment_method: @pix.payment_method,
       payment_category: charge_params[:payment_category], 
       value_with_discount: @discount, billing_due_date: 1.day.from_now.strftime("%d/%m/%Y") )   


    when 'credit_card'
      @discount = @product.price
      @credit_card = CreditCard.find(charge_params[:payment])
      @cvv = charge_params[:cvv]
      @cardholder_name = charge_params[:cardholder_name]
      @credit_card_number = charge_params[:credit_card_number]

      @charge = Charge.create!(company: @company, end_user:@end_user, product: @product,
                                                credit_card:@credit_card, original_value: @product.price, 
                                                cardholder_name: @cardholder_name, credit_card_number: @credit_card_number,
                                                cvv: @cvv, payment_method: @credit_card.payment_method,
                                                payment_category: charge_params[:payment_category], 
                                                value_with_discount: @discount, billing_due_date: 1.day.from_now.strftime("%d/%m/%Y"))
    end
    @charge.save!
    render  json: @charge, status: 201
  rescue ActiveRecord::RecordInvalid
    render status: 422, json:{errors: 'não pode ficar em branco'}
  rescue ActionController::ParameterMissing
    render status: 412, json:{errors: 'Parâmetros inválidos'}
  end

private

  def charge_params
    params.require(:charge).permit(:end_user_token, :product_token, :company_token, :payment, :value_with_discount,
                                    :payment_category, :address, :cardholder_name, :credit_card_number, :cvv, :billing_due_date)
  end

  def not_found
    head 404
  end

  

  def record_invalid(exception)
    render json: exception.record.errors, status: :unprocessable_entity
  end
end
class Api::V1::ChargesController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from ActionController::ParameterMissing, with: :missing_params
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    if charge_params[:payment_category].present?
      @charges = Charge.find_by!(payment_category: charge_params[:payment_category])
    elsif  charge_params[:billing_due_date].present?
      @charges = Charge.find_by!(billing_due_date: charge_params[:billing_due_date])
    else 
      params.fetch(:payment_category)  || params.fetch(:billing_due_date)
    end
    if @charges.present?
    render json:@charges.as_json(except: [:id, :created_at, :updated_at]), status: 200
    end
  end

  def create
    create_charge
    @charge.save!
    render  json: @charge, status: 201
  end

private

  def charge_params
    params.require(:charge).permit(:end_user_token, :product_token, :company_token, :payment, :value_with_discount,
                                    :payment_category, :address, :cardholder_name, :credit_card_number, :cvv, :billing_due_date)
  end

  def not_found
    head 404
  end

  def get_data_for_boleto
    @boleto = Boleto.find(charge_params[:payment])
    @address = charge_params[:address]
    @payment_category  = charge_params[:payment_category]
    @product = Product.find_by(token: charge_params[:product_token])
    @company = Company.find_by(token: charge_params[:company_token])
    @end_user = EndUser.find_by(token: charge_params[:end_user_token])
  end

  def get_data_for_pix
    @pix = Pix.find(charge_params[:payment])
    @payment_category  = charge_params[:payment_category]
    @product = Product.find_by(token: charge_params[:product_token])
    @company = Company.find_by(token: charge_params[:company_token])
    @end_user = EndUser.find_by(token: charge_params[:end_user_token])
  end

  def get_data_for_credit_card
    @credit_card = CreditCard.find(charge_params[:payment])
    @payment_category  = charge_params[:payment_category]
    @product = Product.find_by(token: charge_params[:product_token])
    @company = Company.find_by(token: charge_params[:company_token])
    @end_user = EndUser.find_by(token: charge_params[:end_user_token])
    @cvv =  charge_params[:cvv]
    @credit_card_number = charge_params[:credit_card_number]
    @cardholder_name = charge_params[:cardholder_name]
  end

  def create_charge
    case charge_params[:payment_category]
    when 'boleto'
      get_data_for_boleto
      @charge = Charge.create!(company: @company, end_user:@end_user, product: @product,
      boleto:@boleto, original_value: @product.price, payment_method: @boleto.payment_method, 
      payment_category: @payment_category, address:@address, 
      value_with_discount: set_discount, billing_due_date: 3.days.from_now.strftime("%d/%m/%Y") )           
    when 'pix'
      get_data_for_pix
      @charge = Charge.create!(company: @company, end_user:@end_user, product: @product,
      pix:@pix, original_value: @product.price, payment_method: @pix.payment_method,
       payment_category: @payment_category, 
       value_with_discount: set_discount, billing_due_date: 1.day.from_now.strftime("%d/%m/%Y") )   

    when 'credit_card'
      get_data_for_credit_card
      @charge = Charge.create!(company: @company, end_user:@end_user, product: @product,
                                                credit_card:@credit_card, original_value: @product.price, 
                                                cardholder_name: @cardholder_name, 
                                                credit_card_number: @credit_card_number, 
                                                cvv: @cvv, payment_method: @credit_card.payment_method,
                                                payment_category: @payment_category, 
                                                value_with_discount: set_discount, billing_due_date: 1.day.from_now.strftime("%d/%m/%Y"))
    end
  end

  def set_discount
    case charge_params[:payment_category]
    when 'boleto'
      @product.price - @product.price*10/100

    when 'pix'
      @product.price - @product.price*5/100

    when 'credit_card'
      @product.price
     end
  end

  def record_invalid(exception)
    render json: exception.record.errors, status: :unprocessable_entity
  end

  def missing_params
    render status: 412, json:{errors: 'Parâmetros inválidos'}
  end
end
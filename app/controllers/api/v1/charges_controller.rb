class Api::V1::ChargesController < ActionController::API

  def create
    @company = Company.find_by(token: charge_params[:company_token])
    @product = Product.find_by(token: charge_params[:product_token])
    @end_user = EndUser.find_by(token: charge_params[:end_user_token])

    case charge_params[:payment_category]
    when 'Boleto'
      @boleto = Boleto.find(charge_params[:payment])
      @address = charge_params[:address]
      @charge = Charge.create!(company: @company, end_user:@end_user, product: @product,
                                                  boleto:@boleto, original_value: @product.price, payment_method: @boleto.payment_method)                                                   
    when 'Pix'
      @pix = Pix.find(charge_params[:payment])
      @charge = Charge.create!(company: @company, end_user:@end_user, product: @product,
      pix:@pix, original_value: @product.price, payment_method: @pix.payment_method)   

    when 'Cartão'
      @credit_card = CreditCard.find(charge_params[:payment])
      @cvv = charge_params[:cvv]
      @cardholder_name = charge_params[:cardholder_name]
      @credit_card_number = charge_params[:credit_card_number]
      

      @charge = Charge.create!(company: @company, end_user:@end_user, product: @product,
                                                credit_card:@credit_card, original_value: @product.price, 
                                                cardholder_name: @cardholder_name, credit_card_number: @credit_card_number,
                                                cvv: @cvv, payment_method: @credit_card.payment_method)
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
    params.require(:charge).permit(:end_user_token, :product_token, :company_token, :payment, 
                                    :payment_category, :address, :cardholder_name, :credit_card_number, :cvv)
  end
end
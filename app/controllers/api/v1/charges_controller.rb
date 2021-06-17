class Api::V1::ChargesController < ActionController::API

  def create
    if params[:payment_category] == 'Boleto'
      @boleto = Boleto.find(params[:payment])
    elsif params[:payment_category] == 'Pix'
        @pix = Pix.find(params[:payment])
    elsif params[:payment_category] == 'Cartão'
        @credit_card = CreditCard.find(params[:payment])
    end
    @company = Company.find_by(token: params[:company_token])
    @product = Product.find_by(token: params[:product_token])
    @end_user = EndUser.find_by(cpf: end_user_params[:cpf])
    if @company
      if @end_user
        @company.company_end_users.create!(end_user: @end_user)
      else
        @end_user = @company.company_end_users.create!(end_user: EndUser.create!(end_user_params))
      end
    end
    head 201
    rescue ActiveRecord::RecordInvalid
      render status: 422, json:{errors: 'não pode ficar em branco'}
    rescue ActionController::ParameterMissing
      render status: 412, json:{errors: 'Parâmetros inválidos'}
  end

private

  def end_user_params
    params.require(:end_user).permit(:cpf, :fullname)
  end
end
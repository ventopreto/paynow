class Api::V1::EndUsersController < ActionController::API

  def create
    @company = Company.find_by(token: params[:company_token])
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
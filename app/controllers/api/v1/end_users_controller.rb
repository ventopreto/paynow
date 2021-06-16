class Api::V1::EndUsersController < ActionController::API

  def create
    @end_user = EndUser.new(end_user_params)
    @end_user.save!
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
class Api::V1::EndUsersController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  
    def create
      @company = Company.find_by(token: params[:company_token])
      @end_user = EndUser.find_by(cpf: end_user_params[:cpf])
      if @company
        if @end_user
          @company.company_end_users.create!(end_user: @end_user)
          head 201
        else
          @end_user = @company.company_end_users.create!(end_user: EndUser.create!(end_user_params))
          head 201
        end
      end
    rescue ActionController::ParameterMissing
      render status: :precondition_failed, json: {errors: 'Parâmetros inválidos'}
    end
  
  private
  
    def end_user_params
      params.require(:end_user).permit(:cpf, :fullname)
    end
    def record_invalid(exception)
      render json: exception.record.errors, status: :unprocessable_entity
    end
  end
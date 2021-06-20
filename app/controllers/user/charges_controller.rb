class User::ChargesController < User::UserController

  def index
    @company = current_user.company
    @charges = @company.charges
  end

  def edit
    @company = current_user.company
    @charge = Charge.find_by(token: params[:token])
    @charges = Charge.all
  end

  def update
    @company = current_user.company
    @charge = Charge.find_by(token: params[:token])
    if @charge.update(charge_params)
      redirect_to user_company_charge_path(@company.token, @charge.token)
    else
      render :new
    end
  end

private

  def charge_params
    params.require(:charge).permit(:status)
  end
end
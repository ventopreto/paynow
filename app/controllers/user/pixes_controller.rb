class User::PixesController < User::UserController

  def new
    @payment_method = PaymentMethod.find(params[:payment_method_id])
    @pix = Pix.new
  end

  def create
    @payment_method = PaymentMethod.find(params[:payment_method_id])
    @pix = Pix.create(pix_params)
    @pix.company = current_user.company
    @pix.payment_method = @payment_method
    if @pix.save
    else
      render :new
    end
  end

  def show
  @creditcard = CreditCard.find(params[:id])
  end

private

  def pix_params
    params.require(:pix).permit(:pix_key, :bank_code, :payment_method_id, :company_id)
  end
end
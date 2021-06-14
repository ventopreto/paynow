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
      redirect_to user_payment_method_pix_path(@payment_method, @pix)
    else
      render :new
    end
  end

  def show
  @payment_method = PaymentMethod.find(params[:payment_method_id])
  @pix = Pix.find(params[:id])
  end

  def edit
    @payment_method = PaymentMethod.find(params[:payment_method_id])
    @pix = Pix.find(params[:id])
  end

  def update
    @payment_method = PaymentMethod.find(params[:payment_method_id])
    @pix = Pix.find(params[:id])
    if @pix.update(pix_params)
      redirect_to user_payment_method_pix_path(@payment_method, @boleto)
    else
      render :new
    end
  end

private

  def pix_params
    params.require(:pix).permit(:pix_key, :bank_code, :payment_method_id, :company_id)
  end
end
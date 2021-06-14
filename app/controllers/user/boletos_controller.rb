class User::BoletosController < User::UserController

  def new
    @payment_method = PaymentMethod.find(params[:payment_method_id])
    @boleto = Boleto.new
  end

  def create
    @payment_method = PaymentMethod.find(params[:payment_method_id])
    @boleto = Boleto.new(boleto_params)
    @boleto.company = current_user.company
    @boleto.payment_method = @payment_method
    if @boleto.save
      redirect_to user_payment_method_boleto_path(@payment_method, @boleto)
    else
      render :new
    end
  end

  def show
  @boleto = Boleto.find(params[:id])
  end


  def edit
    @payment_method = PaymentMethod.find(params[:payment_method_id])
    @boleto = Boleto.find(params[:id])
  end

  def update
    @payment_method = PaymentMethod.find(params[:payment_method_id])
    @boleto = Boleto.find(params[:id])
    if @boleto.update(boleto_params)
      redirect_to user_payment_method_boleto_path(@boleto)
    else
      render :new
    end
  end

private

  def boleto_params
    params.require(:boleto).permit(:bank_code, :agency_number, :bank_account, :company_id, :payment_method_id)
  end
end
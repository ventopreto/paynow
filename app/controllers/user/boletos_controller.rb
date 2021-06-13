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
    else
      render :new
    end
  end

  def show
  @boleto = Boleto.find(params[:id])
  end

private

  def boleto_params
    params.require(:boleto).permit(:bank_code, :agency_number, :bank_account, :company_id, :payment_method_id)
  end
end
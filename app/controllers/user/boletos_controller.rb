class User::BoletosController < User::UserController

  def new
    @boleto = Boleto.new
  end

  def create
    @boleto = Boleto.new(boleto_params)
    if @boleto.save
      set_admin
      set_company_id
      redirect_to [:user, @boleto]
    else
      render :new
    end
  end

  def show
  @boleto = Boleto.find(params[:id])
  end

private

  def boleto_params
    params.require(:boleto).permit(:bank_code, :agency_number, :bank_account)
  end
end
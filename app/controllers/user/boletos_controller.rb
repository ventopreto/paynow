class User::BoletosController < User::UserController
  before_action :get_payment_method, only: %i[new create edit update]
  before_action :get_company, only: %i[create show]
  before_action :get_boleto, only: %i[show edit update]

  

  def new
    @boleto = Boleto.new
  end

  def create
    @boleto = Boleto.new(boleto_params)
    @boleto.company = current_user.company
    @boleto.payment_method = @payment_method
    if @boleto.save
      CompanyPayment.create(company: @company, payment_method:@payment_method)
      redirect_to user_payment_method_boleto_path(@payment_method, @boleto)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @boleto.update(boleto_params)
      redirect_to user_payment_method_boleto_path(@boleto)
    else
      render :new
    end
  end

private

  def get_company
    @company = current_user.company
  end

  def get_boleto
    @boleto = Boleto.find(params[:id])
  end

  def get_payment_method
    @payment_method = PaymentMethod.find(params[:payment_method_id])
  end

  def boleto_params
    params.require(:boleto).permit(:bank_code, :agency_number, :bank_account, :company_id, :payment_method_id)
  end
end
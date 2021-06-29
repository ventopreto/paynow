class User::PixesController < User::UserController
  before_action :get_payment_method, only: %i[new create edit update]
  before_action :get_company, only: %i[create show]
  before_action :get_pix, only: %i[show edit update]


  def new
    @pix = Pix.new
  end

  def create
    @pix = Pix.create(pix_params)
    @pix.company = current_user.company
    @pix.payment_method = @payment_method
    if @pix.save
      CompanyPayment.create(company: @company, payment_method:@payment_method)
      redirect_to user_payment_method_pix_path(@payment_method, @pix)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @pix.update(pix_params)
      redirect_to user_payment_method_pix_path(@payment_method, @pix)
    else
      render :edit
    end
  end

private

  def get_company
    @company = current_user.company
  end

  def get_pix
    @pix = Pix.find(params[:id])
  end

  def get_payment_method
    @payment_method = PaymentMethod.find(params[:payment_method_id])
  end

  def pix_params
    params.require(:pix).permit(:pix_key, :bank_code, :payment_method_id, :company_id)
  end
end
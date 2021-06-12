class Admin::PaymentMethodsController <  Admin::AdminController
    before_action :set_payment_method, only: %i[show edit update destroy]
  def index 
    @payment_methods = PaymentMethod.all
  end

  def new
    @payment_method = PaymentMethod.new
  end

  def create
    @payment_method = PaymentMethod.new(payment_method_params)
    if @payment_method.save
      redirect_to [:admin, @payment_method]
    else
      render :new
      flash[:notice] = t('.fail')
    end
  end

  def show

  end

  def edit

  end

  def update
    if @payment_method.update(payment_method_params)
      redirect_to [:admin, @payment_method]
    else
      flash[:notice] = t('.fail')
      render :edit
    end
  end

  def destroy
    @payment_method.destroy
    flash[:success] = t('.success') 
    redirect_to admin_root_path
  end

private

def payment_method_params
  params.require(:payment_method).permit(:name, :max_fee, :percentage_fee, :category)
end

def set_payment_method
  @payment_method = PaymentMethod.find(params[:id])
  end
end
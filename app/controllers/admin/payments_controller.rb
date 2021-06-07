class Admin::PaymentsController <  Admin::AdminController
  def index 
    @payments = PaymentMethod.all
  end

  def new
    @payment = PaymentMethod.new
  end
end
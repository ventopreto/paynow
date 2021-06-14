  class User::PaymentMethodsController < User::UserController

  def index 
    @boletos = Boleto.all
    @pix = Pix.all
    @creditcard = CreditCard.all
    @payment_methods = PaymentMethod.all
  end

  def show 
    @payment_method = PaymentMethod.find(params[:id])
  end
end

  private

  def category_with_name
    "#{@payment_method.category} #{@payment_method.name}"
end



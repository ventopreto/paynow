  class User::PaymentMethodsController < User::UserController

  def index 
    @boletos = Boleto.all
    @pix = Pix.all
    @payment_methods = PaymentMethod.all
  end

  def show 
    @payment_method = PaymentMethod.find(params[:id])
  end
end


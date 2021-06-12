  class User::PaymentMethodsController < User::UserController

  def index 
    @payment_methods = PaymentMethod.all
  end

private

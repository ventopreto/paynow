class User::ChosenPaymentsController < User::UserController

  def index
    @boletos = Boleto.all
    @creditcards = CreditCard.all
    @pixes = Pix.all
  end

  def show
    @payment_method = PaymentMethod.find(params[:id])
    @boleto = Boleto.find(params[:id])
    @creditcards = CreditCard.find(params[:id])
    @pix = Pix.find(params[:id])
  end
end

  private


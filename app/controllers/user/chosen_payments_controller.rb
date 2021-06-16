class User::ChosenPaymentsController < User::UserController

  def index
    @company = current_user.company
    @boletos = @company.boletos
    @creditcards = @company.credit_cards
    @pixes = @company.pixes
  end

  def show
    @payment_method = PaymentMethod.find(params[:id])
    @boleto = Boleto.find(params[:id])
    @creditcards = CreditCard.find(params[:id])
    @pix = Pix.find(params[:id])
  end
end

  private



class User::CreditCardsController < User::UserController

  def new
    @payment_method = PaymentMethod.find(params[:payment_method_id])
    @creditcard = CreditCard.new
  end

  def create
    @payment_method = PaymentMethod.find(params[:payment_method_id])
    @creditcard = CreditCard.new(credit_card_params)
    @creditcard.company = current_user.company
    @creditcard.payment_method = @payment_method
    if @creditcard.save
    else
      render :new
    end
  end

  def show
  @creditcard = CreditCard.find(params[:id])
  end

private

  def credit_card_params
    params.require(:credit_card).permit(:token)
  end
end
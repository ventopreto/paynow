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
      redirect_to user_payment_method_credit_card_path(@payment_method, @creditcard)
    else
      render :new
    end
  end

  def show
  @creditcard = CreditCard.find(params[:id])
  end

  def edit
    @payment_method = PaymentMethod.find(params[:payment_method_id])
    @creditcard = CreditCard.find(params[:id])
  end

  def update
    @payment_method = PaymentMethod.find(params[:payment_method_id])
    @creditcard = CreditCard.find(params[:id])
    if @creditcard.update(credit_card_params)
      redirect_to user_payment_method_creditcard_path(@creditcard)
    else
      render :new
    end
  end

private

  def credit_card_params
    params.require(:credit_card).permit(:token)
  end
end
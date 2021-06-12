class User::CreditCardsController < User::UserController

  def new
    @creditcard = CreditCard.new
  end

  def create
    @creditcard = CreditCard.new(credit_card_params)
    if @creditcard.save
      set_admin
      set_company_id
      redirect_to [:user, @creditcard]
    else
      render :new
    end
  end

  def show
  @creditcard = CreditCard.find(params[:id])
  end

private

  def credit_card_params
    params.require(:creditcard).permit(:token)
  end
end
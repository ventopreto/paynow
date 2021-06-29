class User::CreditCardsController < User::UserController
  before_action :get_payment_method, only: %i[new create edit update]
  before_action :get_company, only: %i[create show]
  before_action :get_credit_card, only: %i[show edit update]

  def new
    @creditcard = CreditCard.new
  end

  def create
    @creditcard = CreditCard.new(credit_card_params)
    @creditcard.company = current_user.company
    @creditcard.payment_method = @payment_method
    if @creditcard.save
      CompanyPayment.create(company: @company, payment_method:@payment_method)
      redirect_to user_payment_method_credit_card_path(@payment_method, @creditcard)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @creditcard.update(credit_card_params)
      redirect_to user_payment_method_credit_card_path(@payment_method, @creditcard)
    else
      render :edit
    end
  end

private

  def get_company
    @company = current_user.company
  end

  def get_credit_card
    @creditcard = CreditCard.find(params[:id])
  end

  def get_payment_method
    @payment_method = PaymentMethod.find(params[:payment_method_id])
  end

  def credit_card_params
    params.require(:credit_card).permit(:token)
  end
end
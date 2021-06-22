class User::ChosenPaymentsController < User::UserController

  def index
    @company = current_user.company
    @boletos = @company.boletos
    @creditcards = @company.credit_cards
    @pixes = @company.pixes
  end
end



class User::CompaniesController < User::UserController
  before_action :get_company, only: %i[show update_token]

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      set_admin
      set_company_id
      redirect_to user_company_path(@company.token)
    else
      render :new
    end
  end

  def show
  @products = @company.products
  end

def update_token
  @company.regenerate_token
  if @company.save
    redirect_to user_company_path(@company.token)
  end
end



private

  def set_admin
    current_user.role =  1
    current_user.save!
  end

  def get_company
    @company = current_user.company
  end

  def set_company_id
    current_user.company = @company
    current_user.save!
  end

  def company_params
    params.require(:company).permit(:cnpj, :corporate_name, :billing_address, :email)
  end

end
class User::CompaniesController < User::UserController

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
  @company = current_user.company
  @products = @company.products
  end

def update_token
  @company = current_user.company
  @company.regenerate_token
  if @company.save
    redirect_to user_company_path(@company.token)
  end
end



private



  def set_admin
    current_user.update_column(:role, 1) 
  end

  def set_company_id
    current_user.update_column(:company_id, @company.id) 
  end

  def company_params
    params.require(:company).permit(:cnpj, :corporate_name, :billing_address, :email)
  end

end
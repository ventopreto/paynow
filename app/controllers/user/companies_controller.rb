class User::CompaniesController < User::UserController
  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      set_admin
      set_company_id
      redirect_to [:user, @company]
    else
      render :new
    end
  end

  def show
  @company = Company.find(params[:id])
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
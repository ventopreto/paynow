class Admin::CompaniesController < Admin::AdminController
before_action :set_company, only: %i[show edit update update_token]

  def index
    @companies = Company.all
  end

  def show

end

def edit

end

def update

  if @company.update(company_params)
    redirect_to [:admin, @company]
  end
end

def update_token
  @company.token = SecureRandom.base64(15)
  if @company.save
    redirect_to [:admin, @company]
  end
end

private

def company_params
  params.require(:company).permit(:cnpj, :corporate_name, :billing_address, :email)
  end

  def set_company
    @company = Company.find(params[:id])
  end
end
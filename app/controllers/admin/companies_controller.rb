class Admin::CompaniesController < Admin::AdminController


  def index
    @companies = Company.all
  end

  def show
  @company = Company.find(params[:id])
end

def edit
  @company = Company.find(params[:id])
end

def update
  @company = Company.find(params[:id])
  if @company.update(company_params)
    redirect_to [:admin, @company]
  end
end

def update_token
  @company = Company.find(params[:id])
  @company.token = SecureRandom.base64(20)
  if @company.save
    redirect_to [:admin, @company]
  end
end


def company_params
  params.require(:company).permit(:cnpj, :corporate_name, :billing_address, :email)
  end
end
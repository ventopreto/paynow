class User::CompaniesController < User::UserController
  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to [:user, @company]
    else
      render :new
    end
  end

  def show
  @company = Company.find(params[:id])
  end
end


def company_params
  params.require(:company).permit(:cnpj, :corporate_name, :billing_address, :email)
end
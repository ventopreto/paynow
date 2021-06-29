class User::ProductsController < User::UserController
  before_action :get_company, only: %i[new create show edit update]
  before_action :get_product, only: %i[show edit update]

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.company = current_user.company
    if  @product.save
      redirect_to user_company_product_path(@company.token, @product)
    else
      render :new
    end
  end


  def show
  end


  def edit
  end

  def update
    @product.company = current_user.company
    if @product.update(product_params)
      redirect_to user_company_product_path(@company.token, @product)
    else
      render :edit
    end
  end



private

  def get_product
    @product = Product.find(params[:id])
  end

  def get_company
    @company = current_user.company
  end

  def product_params
    params.require(:product).permit(:name, :price, :discount, :company_id)
  end

end
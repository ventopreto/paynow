class User::ProductsController < User::UserController

  def new
    @company = Company.find(params[:company_id])
    @product = Product.new
  end

  def create
    @company = current_user.company
    @product = Product.new(product_params)
    @product.company = current_user.company
    if  @product.save
      redirect_to [:user, @company, @product]
    else
      render :new
    end
  end


  def show
    @product = Product.find(params[:id])
  end


  def edit
    @company = Company.find(params[:company_id])
    @product = Product.find(params[:id])
  end

  def update
    @company = current_user.company
    @product = Product.find(params[:id])
    @product.company = current_user.company
    if @product.update(product_params)
      redirect_to [:user, @company, @product]
    else
      render :edit
    end
  end



private

  def product_params
    params.require(:product).permit(:name, :price, :discount, :company_id)
  end

end
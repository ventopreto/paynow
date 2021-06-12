class User::CompaniesController < User::UserController

  def new
    @pix = Pix.new
  end

  def create
    @pix = Pix.new(pixes_params)
    if @pix.save
      redirect_to [:user, @pix]
    else
      render :new
    end
  end

  def show
  @pix = Pix.find(params[:id])
  end

private

  def pixes_params
    params.require(:pixes).permit(:pix_key, :bank_code)
  end
end
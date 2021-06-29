class User::ChargesController < User::UserController
  before_action :get_company, only: %i[index edit update]
  before_action :get_charge, only: %i[edit update]


  def index
    @charges = @company.charges
  end

  def edit
  end

  def update
    if @charge.update!(charge_params)
      create_receipt
    end
  end

private

  def get_company
    @company = current_user.company
  end

  def get_charge
    @charge = Charge.find_by(token: params[:token])
  end

  def create_receipt
    if @charge.status == 'approved'
      @payment_receipt = PaymentReceipt.create!(effective_payment_date: @charge.effective_payment_date,
      billing_due_date:@charge.created_at, authorization_code: params[:charge][:authorization_code], charge: @charge)
     @charge.last_status = '05 Cobrança efetivada com sucesso'
     @charge.approved! 
     redirect_to user_company_charges_path(@company.token)
  else
      if charge_params[:payment_attempt_date].present?
      @charge.last_status = I18n.t "activerecord.attributes.charge.statuses.#{(@charge.status)}"
      @charge.pending!
      redirect_to user_company_charges_path(@company.token)
    else
      flash[:alert] = "Não pode ficar em branco"
      render :edit
      end
    end
  end

  def charge_params
    params.require(:charge).permit(:status ,:effective_payment_date, :payment_attempt_date)
  end
end
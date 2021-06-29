class User::ChargesController < User::UserController
  before_action :get_company, only: %i[index edit update]
  before_action :get_charge, only: %i[edit update]

  def index
    @charges = @company.charges
  end

  def edit
  end

  def update
    if @charge.update(charge_params)
      case @charge.status
      when 'pending'
        @charge.last_status = '01 Pendente de cobrança'
        @charge.pending! 
      when 'insufficient_funds'
        @charge.last_status = '09 Cobrança recusada por falta de créditos'
        @charge.pending! 
      when 'incorrect_data'
        @charge.last_status = '10 Cobrança recusada por dados incorretos para cobrança'
        @charge.pending! 
      when 'refused'
        @charge.last_status = '11 Cobrança recusada sem motivo especificado'
        @charge.pending! 
      when 'approved'
        @payment_receipt = PaymentReceipt.create!(effective_payment_date: @charge.effective_payment_date,
         billing_due_date:@charge.created_at, authorization_code: params[:charge][:authorization_code], charge: @charge)

        @charge.last_status = '05 Cobrança efetivada com sucesso'
        @charge.approved! 

      end
      redirect_to user_company_charges_path(@company.token)
    else
      render :edit
    end
  end

private

  def get_company
    @company = current_user.company
  end

  def get_charge
    @charge = Charge.find_by(token: params[:token])
  end

  def charge_params
    params.require(:charge).permit(:status ,:effective_payment_date, :payment_attempt_date)
  end
end
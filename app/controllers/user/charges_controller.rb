class User::ChargesController < User::UserController

  def index
    @company = current_user.company
    @charges = @company.charges
  end

  def edit
    @company = current_user.company
    @charges = Charge.all
    @charge = Charge.find_by(token: params[:token])
  end

  def update
    @company = current_user.company
    @charge = Charge.find_by(token: params[:token])
    if @charge.update(charge_params)
      case @charge.status
      when 'pendente'
        @charge.last_status = '01 Pendente de cobrança'
        @charge.pendente! 
      when 'rejeitada_1'
        @charge.last_status = '09 Cobrança recusada por falta de créditos'
        @charge.pendente! 
      when 'rejeitada_2'
        @charge.last_status = '10 Cobrança recusada por dados incorretos para cobrança'
        @charge.pendente! 
      when 'rejeitada_3'
        @charge.last_status = '11 Cobrança recusada sem motivo especificado'
        @charge.pendente! 
      when 'aprovada'
        @payment_receipt = PaymentReceipt.create!(effective_payment_date: @charge.effective_payment_date,
         billing_due_date:@charge.created_at, authorization_code: params[:charge][:authorization_code], charge: @charge)

        @charge.last_status = '05 Cobrança efetivada com sucesso'
        @charge.aprovada! 
      end
      redirect_to user_company_charges_path(@company.token)
    else
      render :edit
    end
  end

private

  def charge_params
    params.require(:charge).permit(:status ,:effective_payment_date, :payment_attempt_date)
  end
end
class ReceiptsController < ApplicationController
  def show
    @receipt = PaymentReceipt.find_by(authorization_code: params[:authorization_code])
  end
end
class ReceiptsController < ApplicationController
  def index
    @receipts = PaymentReceipt.all
  end

  def show
    @receipt = PaymentReceipt.find_by(authorization_code: params[:authorization_code])
  end
end
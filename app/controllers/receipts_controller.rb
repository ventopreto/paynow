class ReceiptsController < ApplicationController
  def index
    @receipts = PaymentReceipt.all
  end

  def show
    @receipt = PaymentReceipt.find(params[:id])
  end
end
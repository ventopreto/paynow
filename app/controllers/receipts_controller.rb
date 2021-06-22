class ReceiptsController < ApplicationController
  def index
    @receipts = PaymentReceipt.all
  end
end
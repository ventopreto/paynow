class PaymentReceipt < ApplicationRecord
  belongs_to :charge
  validates :authorization_code, :effective_payment_date, :billing_due_date, presence:true
end

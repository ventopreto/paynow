class Charge < ApplicationRecord
  belongs_to :end_user
  belongs_to :company
  belongs_to :boleto
  belongs_to :pix
  belongs_to :credit_card
  belongs_to :payment_method
end

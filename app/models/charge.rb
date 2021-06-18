class Charge < ApplicationRecord
  belongs_to :end_user
  belongs_to :company
  belongs_to :boleto, optional: true
  belongs_to :pix, optional: true
  belongs_to :credit_card, optional: true
  belongs_to :payment_method
  belongs_to :product
  validates :end_user, :company, :payment_method, :product, :original_value, presence: true
end



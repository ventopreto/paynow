class CreditCard < ApplicationRecord
  belongs_to :company
  belongs_to :payment_method

  validates :token, presence: true
end

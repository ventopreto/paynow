class Pix < ApplicationRecord
  belongs_to :company
  belongs_to :payment_method
  validates :pix_key, uniqueness: true
  validates :pix_key, length: {is:20}
  validates :pix_key, :bank_code, presence: true
end

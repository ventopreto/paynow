class PaymentMethod < ApplicationRecord
  has_one_attached :icon
  validates :name, :max_fee, :percentage_fee, presence: true
end

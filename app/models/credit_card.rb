class CreditCard < ApplicationRecord
  belongs_to :company
  belongs_to :payment_method

  validates :token, presence: true
  validates :token, uniqueness: true
  validates :token, length: {maximum: 20}

  def category_with_name
    "#{payment_method.category} #{payment_method.name}"
  end
end

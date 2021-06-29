class CreditCard < ApplicationRecord
  belongs_to :company
  belongs_to :payment_method
  validates :payment_method, uniqueness: { scope: :company,
  message: "Metodo de Pagamento já cadastrado" }
  validates :token, presence: true
  validates :token, uniqueness: true
  validates :token, length: {maximum: 20}

  def category_with_name
    "Cartão #{payment_method.name}"
  end
end

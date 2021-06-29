class Boleto < ApplicationRecord
  belongs_to :company
  belongs_to :payment_method
  validates :payment_method, uniqueness: { scope: :company,
  message: "Metodo de Pagamento já cadastrado" }

  validates :bank_code, :agency_number, :bank_account, presence: true

  def category_with_name
    ("#{payment_method.category}").capitalize + " #{payment_method.name}"
  end
end

class Pix < ApplicationRecord
  belongs_to :company
  belongs_to :payment_method
  validates :payment_method, uniqueness: { scope: :company,
  message: "Metodo de Pagamento já cadastrado" }
  validates :pix_key, uniqueness: true
  validates :pix_key, length: {is:20}
  validates :pix_key, :bank_code, presence: true  

  def category_with_name
    ("#{payment_method.category}").capitalize + " #{payment_method.name}"
  end
end

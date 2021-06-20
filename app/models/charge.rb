class Charge < ApplicationRecord
  before_create :generate_token
  belongs_to :end_user
  belongs_to :company
  belongs_to :boleto, optional: true
  belongs_to :pix, optional: true
  belongs_to :credit_card, optional: true
  belongs_to :payment_method
  belongs_to :product
  validates :end_user, :company, :payment_method, :product, :original_value, :payment_category, presence: true
  validates :credit_card, :credit_card_number, :cvv, :cardholder_name, presence: true, if: :paid_with_card?
  validates :boleto, :address, presence: true, if: :paid_with_boleto?
  validates :pix, presence: true, if: :paid_with_pix?
  validates :credit_card_number, length: { is: 16 }, if: :paid_with_card?
  validates :cvv, length: { in: 3..4 }, if: :paid_with_card?
  enum payment_category: { Pix:0, Boleto:1, Cartão:2}
  enum status: { pendente:0, aprovada:1, rejeitada_1:2, rejeitada_2:3, rejeitada_3:4}


  def generate_token
    self.token = SecureRandom.base64(15)
  end

  def paid_with_pix?
    self.payment_category == 'Pix'
  end

  def paid_with_boleto?
    self.payment_category == 'Boleto'
  end

  def paid_with_card?
    self.payment_category == 'Cartão'
  end
end


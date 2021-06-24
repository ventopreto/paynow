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
  enum payment_category: { pix:0, boleto:1, credit_card:2}
  enum status: { pending:0, approved:1, insufficient_funds:2, incorrect_data:3, refused:4}


  def generate_token
    self.token = SecureRandom.base64(15)
  end

  def paid_with_pix?
    self.payment_category == 'pix'
  end

  def paid_with_boleto?
    self.payment_category == 'boleto'
  end

  def paid_with_card?
    self.payment_category == 'credit_card'
  end
end


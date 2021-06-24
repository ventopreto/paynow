class PaymentMethod < ApplicationRecord
  has_one_attached :icon
  validates :name, :max_fee, :percentage_fee, presence: true
  has_many :boletos
  has_many :pixes
  has_many :company_payments
  has_many :companies, through: :company_payments
  has_many :credit_cards
  enum category: { pix:0, boleto:1, credit_card:2}

  before_save :set_icons

  def category_with_name
    if category == 'credit_card'
    "Cartão #{name}"
    else
      ("#{category}").capitalize + " #{name}"
    end

  end

  def set_icons
    if PaymentMethod.new.icon.blank?
    case category
    when 'credit_card'
      icon.attach(io: File.open(Rails.root+'spec/fixtures/cartao_icon.png'), filename: 'cartao_icon.png')
    when 'pix'
      icon.attach(io: File.open(Rails.root+'spec/fixtures/pix.png'), filename: 'pix.png')
    when 'boleto'
      icon.attach(io: File.open(Rails.root+'spec/fixtures/boleto.png'), filename: 'boleto.png')
      end
    end
  end
end




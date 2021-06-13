class PaymentMethod < ApplicationRecord
  has_one_attached :icon
  validates :name, :max_fee, :percentage_fee, presence: true
  has_many :boletos
  has_many :pix
  has_many :company_payments
  has_many :companies, through: :company_payments
  has_many :credit_cards
  enum category: { Pix:0, Boleto:1, Cartão:2}

  before_save :set_icons
end

def set_icons
  if PaymentMethod.new.icon.blank?
  case category
  when 'Cartão'
    icon.attach(io: File.open(Rails.root+'spec/fixtures/cartao_icon.png'), filename: 'cartao_icon.png')
  when 'Pix'
    icon.attach(io: File.open(Rails.root+'spec/fixtures/pix.png'), filename: 'pix.png')
  when 'Boleto'
    icon.attach(io: File.open(Rails.root+'spec/fixtures/boleto.png'), filename: 'boleto.png')
  else
    icon.attach(io: File.open(Rails.root+'spec/fixtures/Missing.png'), filename: 'Missing.png')
    end
  end
end


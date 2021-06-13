class Company < ApplicationRecord
  before_create :generate_token
  has_many :users
  has_many :company_payments
  has_many :payment_methods, through: :company_payments
  after_save :set_domain
  validates :email, :cnpj, :corporate_name, :billing_address, presence: true
  validates :email, format:{ with: /[^@\s]+@(?!gmail|yahoo|hotmail|paynow)[^@]+\.[^@]*/}
  validates :cnpj, length: {is: 14}


end

def set_domain
  self.update_column(:email_domain, self.email.split('@')[1])
end

def generate_token
  self.token = SecureRandom.base64(20)
end



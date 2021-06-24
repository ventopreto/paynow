class Company < ApplicationRecord
  before_create :generate_token
  has_many :company_end_users
  has_many :end_users, through: :company_end_users
  has_many :users
  has_many :products
  has_many :company_payments
  has_many :boletos
  has_many :pixes
  has_many :credit_cards
  has_many :charges
  has_many :payment_methods, through: :company_payments
  after_save :set_domain
  validates :email, :cnpj, :corporate_name, uniqueness: true
  validates :email, :cnpj, :corporate_name, :billing_address, presence: true
  validates :email, format:{ with: /[^@\s]+@(?!gmail|yahoo|hotmail|paynow)[^@]+\.[^@]*/}
  validates :cnpj, length: {is: 14}


  def set_domain
    self.update_column(:email_domain, self.email.split('@')[1])
  end
  
  def regenerate_token
    self.token = SecureRandom.base64(15) 
  end

  def generate_token
    self.token = SecureRandom.base64(15) 
    end
end





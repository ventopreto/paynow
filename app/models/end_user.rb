class EndUser < ApplicationRecord
  before_create :generate_token
  
  validates :cpf, :fullname, presence: true
  validates :cpf, length: {is: 11}
  validates :cpf, uniqueness: true
  has_many :company_end_users
  has_many :companies, through: :company_end_users

  def generate_token
    self.token = SecureRandom.base64(15)
  end
end


class EndUser < ApplicationRecord
  has_secure_token :token
  validates :cpf, :fullname, presence: true
  has_many :company_end_users
  has_many :companies, through: :company_end_users
end


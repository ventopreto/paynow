class EndUser < ApplicationRecord
  has_secure_token :token
  validates :cpf, :fullname, presence: true
end


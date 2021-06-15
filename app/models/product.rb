class Product < ApplicationRecord
  before_create :generate_token
  validates :name, :price, presence: true
  belongs_to :company
end


def generate_token
  self.token = SecureRandom.base64(20)
end
class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable
  validates :email, format: { with: /[^@\s]+@paynow\.com\.br/,
  message: "Email não autorizado" }
end

class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, format: { with: /\A[^@\s]+@(?<=@)(paynow)\.[^@]+\Z/,
  message: "Email não autorizado" }
end

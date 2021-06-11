class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  after_create :set_employer
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, format:{with: /[^@]+@(?!gmail|yahoo|hotmail|paynow)[^@]+\.[^@]*/}
  enum role: { employer: 0, admin: 1}
end

def set_employer
  company = Company.where(email_domain: self.email.split('@')[1])
if company[0] != nil
  self.update_column(:company_id, company[0].id)
  end
end
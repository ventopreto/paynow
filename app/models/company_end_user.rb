class CompanyEndUser < ApplicationRecord
  belongs_to :company
  belongs_to :end_user
end

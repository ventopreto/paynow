require 'rails_helper'

describe Company do
  it { should have_many(:end_users).through(:company_end_users) }
end

describe EndUser do
  it { should have_many(:companies).through(:company_end_users) }
end
require 'rails_helper'

describe Company do
  it { should have_many(:payment_methods).through(:company_payments) }
end

describe PaymentMethod do
  it { should have_many(:companies).through(:company_payments) }
end
require 'rails_helper'

describe PaymentMethod do
  describe 'Validate' do
    it 'attributes cannot be blank' do
    credit_card =PaymentMethod.new
    pix = PaymentMethod.new

    pix.valid?
    credit_card.valid?

    expect(pix.errors[:name]).to include('não pode ficar em branco')
    expect(pix.errors[:max_fee]).to include('não pode ficar em branco')
    expect(pix.errors[:percentage_fee]).to include('não pode ficar em branco')
    expect(pix).to_not be_valid

    expect(credit_card.errors[:name]).to include('não pode ficar em branco')
    expect(credit_card.errors[:max_fee]).to include('não pode ficar em branco')
    expect(credit_card.errors[:percentage_fee]).to include('não pode ficar em branco')
    expect(credit_card).to_not be_valid
    end

    it 'success to create a payment method' do
      credit_card =PaymentMethod.new(name: 'Visa', max_fee: 20, percentage_fee: 10)
      pix = PaymentMethod.new(name: 'pix', max_fee: 30, percentage_fee: 10)
  
      pix.valid?
      credit_card.valid?
  
      expect(pix.name).to eq('pix')
      expect(pix.max_fee).to eq(30)
      expect(pix.percentage_fee).to eq(10)
      expect(pix).to be_valid
  
      expect(credit_card.name).to eq('Visa')
      expect(credit_card.max_fee).to eq(20)
      expect(credit_card.percentage_fee).to eq(10)
      expect(credit_card).to be_valid
    end
  end
end
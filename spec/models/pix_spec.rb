require 'rails_helper'

describe Pix do
  describe 'Validate' do
    it 'attributes cannot be blank' do
    pix = Pix.new


    pix.valid?

    expect(pix.errors[:pix_key]).to include('não pode ficar em branco')
    expect(pix.errors[:bank_code]).to include('não pode ficar em branco')
    expect(pix).to_not be_valid

    end

    it 'success register a pix' do
      token = SecureRandom.base64(20)
      codeplay =Company.create(email: 'codeplay@codeplay.com.br', cnpj: 12345678910110, 
      billing_address:'Rua Tal, 50, Centro',
      corporate_name: 'codeplay ltda')
      payment = PaymentMethod.new(name: 'pix', max_fee: 30, percentage_fee: 10)
      pix = Pix.new(pix_key: token, bank_code: 1234, company_id: codeplay.id, payment_method_id: payment.id)
  
      pix.valid?
  
      expect(pix.pix_key).to eq(token)
      expect(pix.bank_code).to eq(1234)
      expect(pix).to be_valid
    end
  end
end
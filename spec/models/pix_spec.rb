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
      token = SecureRandom.base64(15)
      codeplay =Company.create(email: 'codeplay@codeplay.com.br', cnpj: 12345678910110, 
      billing_address:'Rua Tal, 50, Centro',
      corporate_name: 'codeplay ltda')
      payment = PaymentMethod.create(name: 'pix', max_fee: 30, percentage_fee: 10, category: "pix")
      pix = Pix.create(pix_key: token, bank_code: 1234, company_id: codeplay.id, payment_method_id: payment.id)

      payment.valid?
      pix.valid?
  

      expect(pix.pix_key).to eq(token)
      expect(pix.bank_code).to eq(1234)
      expect(payment).to be_valid
      expect(pix).to be_valid
    end

    it 'ensure pix key is unique' do
      token = SecureRandom.base64(15)
      codeplay =Company.create(email: 'codeplay@codeplay.com.br', cnpj: 12345678910110, 
      billing_address:'Rua Tal, 50, Centro',
      corporate_name: 'codeplay ltda')
      payment = PaymentMethod.create(name: 'pix', max_fee: 30, percentage_fee: 10, category: "pix")
      pix1 = Pix.create(pix_key: token, bank_code: 1234, company_id: codeplay.id, payment_method_id: payment.id)
      pix2 = Pix.create(pix_key: token, bank_code: 321, company_id: codeplay.id, payment_method_id: payment.id)

      pix1.valid?
      pix2.valid?
  
      expect(pix2.errors[:pix_key]).to include('já está em uso')
      expect(pix1).to be_valid
      expect(pix2).to_not be_valid
    end

    it 'ensure pix key have 20 characters' do
      token = SecureRandom.base64(10)
      codeplay =Company.create(email: 'codeplay@codeplay.com.br', cnpj: 12345678910110, 
      billing_address:'Rua Tal, 50, Centro',
      corporate_name: 'codeplay ltda')
      payment = PaymentMethod.create(name: 'pix', max_fee: 30, percentage_fee: 10, category: "pix")
      pix2 = Pix.create(pix_key: token, bank_code: 321, company_id: codeplay.id, payment_method_id: payment.id)


      pix2.valid?
  
      expect(pix2.errors[:pix_key]).to include('não possui o tamanho esperado (20 caracteres)')
      expect(pix2).to_not be_valid
    end
  end
end
require 'rails_helper'

describe CreditCard do
  describe 'Validate' do
    it 'attributes cannot be blank' do
    cartão = CreditCard.new


    cartão.valid?

    expect(cartão.errors[:token]).to include('não pode ficar em branco')
    expect(cartão).to_not be_valid

    end

    it 'success register a boleto' do
      token = SecureRandom.base64(20)
      codeplay =Company.create(email: 'codeplay@codeplay.com.br', cnpj: 12345678910110, 
      billing_address:'Rua Tal, 50, Centro',
      corporate_name: 'codeplay ltda')
      payment = PaymentMethod.create(name: 'pix', max_fee: 30, percentage_fee: 10, category: "Cartão")
      cartão = CreditCard.create(token: token, payment_method_id: payment.id, company_id: codeplay.id)
  
      cartão.valid?
  
      expect(cartão.token).to eq(token)
      expect(cartão).to be_valid
    end
  end
end
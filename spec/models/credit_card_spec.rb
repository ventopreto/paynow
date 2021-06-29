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
      token = SecureRandom.base64(15)
      codeplay =Company.create(email: 'codeplay@codeplay.com.br', cnpj: 12345678910110, 
      billing_address:'Rua Tal, 50, Centro',
      corporate_name: 'codeplay ltda')
      payment = PaymentMethod.create(name: 'pix', max_fee: 30, percentage_fee: 10, category: "credit_card")
      cartão = CreditCard.create(token: token, payment_method_id: payment.id, company_id: codeplay.id)
  
      cartão.valid?
  
      expect(cartão.token.size).to eq(20)
      expect(cartão).to be_valid
    end

    it 'cannot register same payment method twice' do
      token = SecureRandom.base64(15)
      codeplay =Company.create(email: 'codeplay@codeplay.com.br', cnpj: 12345678910110, 
      billing_address:'Rua Tal, 50, Centro',
      corporate_name: 'codeplay ltda')
      xbox =Company.create(email: 'admin@xbox.com.br', cnpj: 12345678910166, 
      billing_address:'Rua Tal, 50, Centro',
      corporate_name: 'Xbox ltda')
  
      payment = PaymentMethod.create(name: 'pix', max_fee: 30, percentage_fee: 10, category: "credit_card")
      credit_card = CreditCard.create(token: token, payment_method_id: payment.id, company_id: codeplay.id)
      another_credit_card = CreditCard.create(token: token, payment_method_id: payment.id, company_id: codeplay.id)
      other_credit_card = CreditCard.create(token: SecureRandom.base64(15), payment_method_id: payment.id, company_id: xbox.id)
  
  
      credit_card.valid?
      another_credit_card.valid?
      other_credit_card.valid?
  
      expect(credit_card).to be_valid
      expect(another_credit_card.errors[:payment_method]).to include("Metodo de Pagamento já cadastrado")
      expect(other_credit_card).to be_valid
      end
  end
end
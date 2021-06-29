require 'rails_helper'

describe Boleto do
  describe 'Validate' do
    it 'attributes cannot be blank' do
    boleto = Boleto.new


    boleto.valid?

    expect(boleto.errors[:bank_code]).to include('não pode ficar em branco')
    expect(boleto.errors[:agency_number]).to include('não pode ficar em branco')
    expect(boleto.errors[:bank_account]).to include('não pode ficar em branco')
    expect(boleto).to_not be_valid

    end

    it 'success register a boleto' do
      boleto = Boleto.create(bank_code: 123, agency_number: 1234, bank_account: 123456789)
      codeplay =Company.create(email: 'codeplay@codeplay.com.br', cnpj: 12345678910110, 
      billing_address:'Rua Tal, 50, Centro',
      corporate_name: 'codeplay ltda')
      payment = PaymentMethod.create(name: 'Banco Roxinho', max_fee: 30, percentage_fee: 10, category: 'boleto')
      boleto = Boleto.create(bank_code: 123, agency_number: 1234, bank_account: 123456789, company_id: codeplay.id, payment_method_id: payment.id)

  
  
      boleto.valid?
  
      expect(boleto.bank_code).to eq(123)
      expect(boleto.agency_number).to eq(1234)
      expect(boleto.bank_account).to eq(123456789)
      expect(boleto).to be_valid
      expect(boleto.category_with_name).to eq('Boleto Banco Roxinho')
    end

  it 'cannot register same payment method twice' do
    boleto = Boleto.create(bank_code: 123, agency_number: 1234, bank_account: 123456789)
    codeplay =Company.create(email: 'codeplay@codeplay.com.br', cnpj: 12345678910110, 
    billing_address:'Rua Tal, 50, Centro',
    corporate_name: 'codeplay ltda')
    xbox =Company.create(email: 'admin@xbox.com.br', cnpj: 12345678910166, 
    billing_address:'Rua Tal, 50, Centro',
    corporate_name: 'Xbox ltda')

    payment = PaymentMethod.create(name: 'Banco Roxinho', max_fee: 30, percentage_fee: 10, category: 'boleto')
    boleto = Boleto.create!(bank_code: 123, agency_number: 1234, bank_account: 123456789, company_id: codeplay.id, payment_method_id: payment.id)
    another_boleto = Boleto.new(bank_code: 153, agency_number: 12345, bank_account: 1234567890, company_id: codeplay.id, payment_method_id: payment.id)
    other_boleto = Boleto.new(bank_code: 122, agency_number: 54321, bank_account: 9876543210, company_id: xbox.id, payment_method_id: payment.id)


    boleto.valid?
    another_boleto.valid?
    other_boleto.valid?

    expect(boleto).to be_valid
    expect(another_boleto.errors[:payment_method]).to include("Metodo de Pagamento já cadastrado")
    expect(other_boleto).to be_valid
    end
  end
end
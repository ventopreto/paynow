require 'rails_helper'

describe Charge do
  let!(:product1)  {Product.create(name: 'Curso Ruby', price: 30, company: company1)}
  let!(:product2) {Product.create(name: 'Curso Rails', price: 45, company: company1)}
  let!(:company1) {Company.create(cnpj: 12345678910110, corporate_name: 'Codeplay', 
  billing_address: 'Rua x, 420', email: 'admin@codeplay.com.br' )}
  let!(:payment_method_boleto) {PaymentMethod.create!(name: 'Banco Roxinho', max_fee: 10, percentage_fee:10, category: 'Boleto')}
  let!(:payment_method_credit_card) {PaymentMethod.create!(name: 'Banco Roxinho', max_fee: 10, percentage_fee:10, category: 2)}
  let!(:payment_method_pix) {PaymentMethod.create!(name: 'Banco Roxinho', max_fee: 10, percentage_fee:10, category: 'Pix')}
  let!(:boleto) {Boleto.create!(bank_code: 102, agency_number:1234, bank_account: 123456, payment_method:payment_method_boleto, company: company1)}
  let!(:pix) {Pix.create!(bank_code: 102, pix_key:12345678909876543210, payment_method:payment_method_pix, company: company1)}
  let!(:credit_card) {CreditCard.create!(token:12345678909876543210, payment_method:payment_method_credit_card, company: company1)}
  let!(:companypayment1) {CompanyPayment.create!(company: company1, payment_method: payment_method_boleto)}
  let!(:companypayment2) {CompanyPayment.create!(company: company1, payment_method: payment_method_credit_card)}
  let!(:companypayment2) {CompanyPayment.create!(company: company1, payment_method: payment_method_pix)}
  let!(:end_user1) {EndUser.create!(cpf:12345678910, fullname:'Fulano Sicrano')}
  describe 'Validate' do
    it 'attributes cannot be blank' do
    charge = Charge.new


    charge.valid?
    expect(charge.errors[:payment_category]).to include('não pode ficar em branco')
    expect(charge.errors[:end_user]).to include('não pode ficar em branco')
    expect(charge.errors[:company]).to include('não pode ficar em branco')
    expect(charge.errors[:product]).to include('não pode ficar em branco')
    expect(charge.errors[:original_value]).to include('não pode ficar em branco')
    expect(charge).to_not be_valid

    end

    it 'success register a charge with boleto' do
      charge = Charge.create!(payment_category:boleto.payment_method.category,
       payment_method: boleto.payment_method, company: company1, 
      boleto: boleto, address: 'Rua H 500', end_user: end_user1, product: product1, original_value: product1.price)

  
  
      charge.valid?
      expect(Charge.count).to eq(1)
      expect(charge.end_user).to eq(end_user1)
      expect(charge.payment_category).to eq('Boleto')
      expect(charge.payment_method).to eq(boleto.payment_method)
      expect(charge.boleto).to eq(boleto)
      expect(charge.address).to eq('Rua H 500')
      expect(charge.company).to eq(company1)
      expect(charge.product).to eq(product1)
      expect(charge.original_value).to eq(product1.price)
      expect(charge).to be_valid
    end

    it 'success register a charge with pix' do
      charge = Charge.create!(payment_category:pix.payment_method.category,
       payment_method: pix.payment_method, company: company1, 
      pix: pix, end_user: end_user1, product: product1, original_value: product1.price)

      charge.valid?
      expect(Charge.count).to eq(1)
      expect(charge.end_user).to eq(end_user1)
      expect(charge.payment_category).to eq('Pix')
      expect(charge.payment_method).to eq(pix.payment_method)
      expect(charge.pix).to eq(pix)
      expect(charge.company).to eq(company1)
      expect(charge.product).to eq(product1)
      expect(charge.address).to eq(nil)
      expect(charge.original_value).to eq(product1.price)
      expect(charge).to be_valid
    end

    it 'success register a charge with credit card' do
      charge = Charge.create!(payment_category:credit_card.payment_method.category,
       payment_method: credit_card.payment_method, company: company1, 
      credit_card: credit_card, cvv: 123, cardholder_name: 'Fulano Sicrano', credit_card_number: 1234567891012345 ,end_user: end_user1, product: product1, original_value: product1.price)

      charge.valid?
      expect(Charge.count).to eq(1)
      expect(charge.end_user).to eq(end_user1)
      expect(charge.payment_category).to eq('Cartão')
      expect(charge.payment_method).to eq(credit_card.payment_method)
      expect(charge.credit_card).to eq(credit_card)
      expect(charge.cvv).to eq(123)
      expect(charge.cardholder_name).to eq('Fulano Sicrano')
      expect(charge.company).to eq(company1)
      expect(charge.address).to eq(nil)
      expect(charge.product).to eq(product1)
      expect(charge.original_value).to eq(product1.price)
      expect(charge).to be_valid
    end

    it 'ensure cvv have at most 4 digits' do
      charge = Charge.create(payment_category:credit_card.payment_method.category,
       payment_method: credit_card.payment_method, company: company1, 
      credit_card: credit_card, cvv: 12356, cardholder_name: 'Fulano Sicrano', credit_card_number: 1234567891012345 ,end_user: end_user1, product: product1, original_value: product1.price)

      charge.valid?

      expect(charge.errors[:cvv]).to include('é muito longo (máximo: 4 caracteres)')
      expect(charge).to_not be_valid
    end

    it 'ensure cvv have at least 3 digits' do
      charge = Charge.create(payment_category:credit_card.payment_method.category,
       payment_method: credit_card.payment_method, company: company1, 
      credit_card: credit_card, cvv: 12, cardholder_name: 'Fulano Sicrano', credit_card_number: 1234567891012345 ,end_user: end_user1, product: product1, original_value: product1.price)

      charge.valid?

      expect(charge.errors[:cvv]).to include('é muito curto (mínimo: 3 caracteres)')
      expect(charge).to_not be_valid
    end

    it 'ensure credit card number have 16 digits' do
      charge = Charge.create(payment_category:credit_card.payment_method.category,
       payment_method: credit_card.payment_method, company: company1, 
      credit_card: credit_card, cvv: 12356, cardholder_name: 'Fulano Sicrano', credit_card_number: 123 ,end_user: end_user1, product: product1, original_value: product1.price)

      charge.valid?

      expect(charge.errors[:credit_card_number]).to include('não possui o tamanho esperado (16 caracteres)')
      expect(charge).to_not be_valid
    end
  end
end
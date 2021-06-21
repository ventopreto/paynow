require 'rails_helper'

describe PaymentReceipt do
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
  let!(:charge1) {Charge.create!(payment_category:boleto.payment_method.category,  payment_method: boleto.payment_method, company: company1, 
 boleto: boleto, address: 'Rua H 500', end_user: end_user1, product: product1, original_value: product1.price)}

  describe 'Validate' do
    it 'attributes cannot be blank' do
    recibo = PaymentReceipt.new


    recibo.valid?

    expect(recibo.errors[:authorization_code]).to include('não pode ficar em branco')
    expect(recibo.errors[:effective_payment_date]).to include('não pode ficar em branco')
    expect(recibo.errors[:billing_due_date]).to include('não pode ficar em branco')
    expect(recibo).to_not be_valid

    end

    it 'success register a boleto' do
      charge = charge1
      recibo = PaymentReceipt.create(authorization_code: '123456', effective_payment_date: Date.today, billing_due_date: Date.today, charge: charge)

  
  
      recibo.valid?
  
      expect(recibo.authorization_code).to eq('123456')
      expect(recibo.effective_payment_date).to eq(Date.today.to_s)
      expect(recibo.billing_due_date).to eq(Date.today.to_s)
      expect(recibo).to be_valid
    end
  end
end
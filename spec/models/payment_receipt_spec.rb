require 'rails_helper'

describe PaymentReceipt do
  let(:ruby_course)  {Product.create(name: 'Curso Ruby', price: 30, company: codeplay)}
  let(:rails_course) {Product.create(name: 'Curso Rails', price: 45, company: codeplay)}
  let(:codeplay) {Company.create(cnpj: 12345678910110, corporate_name: 'Codeplay', 
  billing_address: 'Rua x, 420', email: 'admin@codeplay.com.br' )}
  let(:payment_method_boleto) {PaymentMethod.create!(name: 'Banco Roxinho', max_fee: 10, percentage_fee:10, category: 'boleto')}
  let(:payment_method_credit_card) {PaymentMethod.create!(name: 'Banco Roxinho', max_fee: 10, percentage_fee:10, category: 2)}
  let(:payment_method_pix) {PaymentMethod.create!(name: 'Banco Roxinho', max_fee: 10, percentage_fee:10, category: 'pix')}
  let(:boleto) {Boleto.create!(bank_code: 102, agency_number:1234, bank_account: 123456, payment_method:payment_method_boleto, company: codeplay)}
  let(:pix) {Pix.create!(bank_code: 102, pix_key:12345678909876543210, payment_method:payment_method_pix, company: codeplay)}
  let(:credit_card) {CreditCard.create!(token:12345678909876543210, payment_method:payment_method_credit_card, company: codeplay)}
  let(:companypayment_boleto) {CompanyPayment.create!(company: codeplay, payment_method: payment_method_boleto)}
  let(:companypayment_credit_card) {CompanyPayment.create!(company: codeplay, payment_method: payment_method_credit_card)}
  let(:companypayment_pix) {CompanyPayment.create!(company: codeplay, payment_method: payment_method_pix)}
  let(:end_user) {EndUser.create!(cpf:12345678910, fullname:'Fulano Sicrano')}
  let(:charge) {Charge.create!(payment_category:boleto.payment_method.category,  payment_method: boleto.payment_method, company: codeplay, 
 boleto: boleto, address: 'Rua H 500', end_user: end_user, product: ruby_course, original_value: ruby_course.price)}

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
      Charge.create!(payment_category:boleto.payment_method.category,  payment_method: boleto.payment_method, company: codeplay, 
      boleto: boleto, address: 'Rua H 500', end_user: end_user, product: ruby_course, original_value: ruby_course.price)
      recibo = PaymentReceipt.create(authorization_code: '123456', effective_payment_date: Date.today, billing_due_date: Date.today, charge: charge)

  
  
      recibo.valid?
  
      expect(recibo.authorization_code).to eq('123456')
      expect(recibo.effective_payment_date).to eq(Date.today.to_s)
      expect(recibo.billing_due_date).to eq(Date.today.to_s)
      expect(recibo).to be_valid
    end
  end
end
require 'rails_helper'

describe 'User' do
  let(:product1)  {Product.create(name: 'Gamepass PC', price: 30, company: company1)}
  let(:product2) {Product.create(name: 'Gamepass Ultimate', price: 45, company: company1)}
  let(:company1) {Company.create(cnpj: 12345678910110, corporate_name: 'Xbox', 
  billing_address: 'Rua x, 420', email: 'admin@xbox.com.br' )}
  let!(:payment_method_boleto) {PaymentMethod.create!(name: 'Banco Roxinho', max_fee: 10, percentage_fee:10, category: 'Boleto')}
  let!(:payment_method_credit_card) {PaymentMethod.create!(name: 'Banco Roxinho', max_fee: 10, percentage_fee:10, category: 2)}
  let!(:payment_method_pix) {PaymentMethod.create!(name: 'Banco Roxinho', max_fee: 10, percentage_fee:10, category: 'Pix')}
  let(:boleto) {Boleto.create!(bank_code: 102, agency_number:1234, bank_account: 123456, payment_method:payment_method_boleto, company: company1)}
  let(:pix) {Pix.create!(bank_code: 102, pix_key:12345678909876543210, payment_method:payment_method_pix, company: company1)}
  let(:credit_card) {CreditCard.create!(token:12345678909876543210, payment_method:payment_method_credit_card, company: company1)}
  let(:companypayment1) {CompanyPayment.create!(company: company1, payment_method: payment_method_boleto)}
  let(:end_user1) {EndUser.create!(cpf:12345678910, fullname:'Fulano Sicrano')}
  let(:user) { User.create(email:'x@x.com.br',password: '123456', role:1, company_id: company1.id)}
  it 'Admin should change charge status successfuly' do
    charge = Charge.create!(payment_category: 'Boleto', address: 'Rua x 420', boleto: boleto, end_user:end_user1, company: company1, 
    payment_method: boleto.payment_method, product: product1, original_value: product1.price,
     value_with_discount: product1.price)

    login_as user, scope: :user
    visit root_path
    click_on 'Dados da Empresa'
    click_on 'Ver Cobranças'

    expect(Charge.count).to eq(1)
    end
end



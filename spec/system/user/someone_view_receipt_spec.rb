require 'rails_helper'

describe 'Show receipt' do
  let(:product1)  {Product.create(name: 'Gamepass PC', price: 30, company: company1)}
  let(:product2) {Product.create(name: 'Gamepass Ultimate', price: 45, company: company1)}
  let(:company1) {Company.create(cnpj: 12345678910110, corporate_name: 'Xbox', 
  billing_address: 'Rua x, 420', email: 'admin@xbox.com.br' )}
  let(:payment_method_boleto) {PaymentMethod.create!(name: 'Banco Roxinho', max_fee: 10, percentage_fee:10, category: 'boleto')}
  let(:payment_method_credit_card) {PaymentMethod.create!(name: 'Banco Roxinho', max_fee: 10, percentage_fee:10, category: 2)}
  let(:payment_method_pix) {PaymentMethod.create!(name: 'Banco Roxinho', max_fee: 10, percentage_fee:10, category: 'pix')}
  let(:boleto) {Boleto.create!(bank_code: 102, agency_number:1234, bank_account: 123456, payment_method:payment_method_boleto, company: company1)}
  let(:pix) {Pix.create!(bank_code: 102, pix_key:12345678909876543210, payment_method:payment_method_pix, company: company1)}
  let(:credit_card) {CreditCard.create!(token:12345678909876543210, payment_method:payment_method_credit_card, company: company1)}
  let(:companypayment1) {CompanyPayment.create!(company: company1, payment_method: payment_method_boleto)}
  let(:end_user1) {EndUser.create!(cpf:12345678910, fullname:'Fulano Sicrano')}
  let(:user1) { User.create(email:'x@x.com.br',password: '123456', role:1, company_id: company1.id)}
  context 'when logged out' do
    it 'successfully' do

      charge = Charge.create!(payment_category: 'boleto', address: 'Rua x 420', boleto: boleto, end_user:end_user1, company: company1, 
      payment_method: boleto.payment_method, product: product1, original_value: product1.price,
       value_with_discount: product1.price)
       receipt = PaymentReceipt.create!(effective_payment_date: Date.today,
       billing_due_date: charge.created_at, authorization_code: SecureRandom.base64(15), charge: charge)

       visit receipt_path(receipt.authorization_code)
       expect(page).to have_content(receipt.authorization_code)
       expect(page).to have_content(receipt.effective_payment_date)
       expect(page).to have_content(receipt.billing_due_date)
    end
  end

    context 'when logged in' do
      it 'successfully' do
        
        login_as user1
        charge = Charge.create!(payment_category: 'boleto', address: 'Rua x 420', boleto: boleto, end_user:end_user1, company: company1, 
        payment_method: boleto.payment_method, product: product1, original_value: product1.price,
         value_with_discount: product1.price)
         receipt = PaymentReceipt.create!(effective_payment_date: Date.today,
         billing_due_date: charge.created_at, authorization_code: SecureRandom.base64(15), charge: charge)
  
         visit receipt_path(receipt.authorization_code)
         expect(page).to have_content(receipt.authorization_code)
         expect(page).to have_content(receipt.effective_payment_date)
         expect(page).to have_content(receipt.billing_due_date)
      end
  end
end



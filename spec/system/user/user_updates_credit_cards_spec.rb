require 'rails_helper'

describe 'User' do
  let!(:company) { Company.create!(cnpj: '12345678910110', corporate_name: 'Codeplay', 
  billing_address: 'Rua x, 420', email: 'admin@codeplay.com.br' )}
  let!(:user) {User.create!(email:'x@x.com.br',password: '123456', company: company, role:1)}
  let!(:payment_method_credit_card) {PaymentMethod.create!(name: 'Banco Roxinho', max_fee: 10, percentage_fee:10, category: 'credit_card')}
  let!(:credit_card) {CreditCard.create!(token:12345678909876543210, payment_method:payment_method_credit_card, company: company)}
  let!(:companypayment_credit_card) {CompanyPayment.create!(company: company, payment_method: payment_method_credit_card)}
  let!(:payment_method_pix) {PaymentMethod.create!(name: 'Banco Roxinho', max_fee: 10, percentage_fee:10, category: 'pix')}
  let!(:pix) {Pix.create!(bank_code: 102, pix_key:12345678909876543210, payment_method:payment_method_pix, company: company)}
  let!(:companypayment_pix) {CompanyPayment.create!(company: company, payment_method: payment_method_pix)}

  describe 'updates' do
    it 'creditcard successfully' do
      login_as user, scope: :user
      visit root_path
      click_on 'Meios de Pagamento Escolhidos'
      click_on 'Cartão Banco Roxinho'
      click_on 'Editar'
      fill_in 'Código Alfanumérico', with: 123456789012345678
      click_on 'Atualizar'
  
      expect(page).to have_content("Cartão Banco Roxinho")
      expect(page).to have_content("Taxa(%): 10.0")
      expect(page).to have_content("Taxa Maxima: R$ 10,00")
      expect(page).to have_content("Código Alfanumérico: 123456789012345678")

      end

      it 'credit card with blank fields' do
        login_as user, scope: :user
        visit root_path
        click_on 'Meios de Pagamento Escolhidos'
        click_on 'Cartão Banco Roxinho'
        click_on 'Editar'
        fill_in 'Código Alfanumérico', with: ''
        click_on 'Atualizar'
    
        expect(page).to have_content('não pode ficar em branco')
      end
  end
end

require 'rails_helper'

describe User do
  let(:company) {Company.create!(email:'admin@codeplay.com.br', billing_address: 'Rua x, 420',
  corporate_name: 'Codeplay', cnpj:12345678910110)}
  let!(:payment_method_boleto) {PaymentMethod.create!(name: 'Banco Roxinho', max_fee: 10, percentage_fee:10, category: 'Boleto')}
  let!(:payment_method_credit_card) {PaymentMethod.create!(name: 'Banco Roxinho', max_fee: 10, percentage_fee:10, category: 2)}
  let!(:payment_method_pix) {PaymentMethod.create!(name: 'Banco Roxinho', max_fee: 10, percentage_fee:10, category: 'Pix')}
  let(:boleto) {Boleto.create!(bank_code: 102, agency_number:1234, bank_account: 123456, payment_method:payment_method_boleto, company: company)}
  let(:pix) {Pix.create!(bank_code: 102, pix_key:12345678909876543210, payment_method:payment_method_pix, company: company)}
  let(:credit_card) {CreditCard.create!(token:12345678909876543210, payment_method:payment_method_credit_card, company: company)}
  let(:user) {User.create!(email:'x@x.com.br',password: '123456', company: company)}

  describe 'View chosen payments' do
    it 'successfully' do
      pix = Pix.create!(bank_code: 102, pix_key:12345678909876543210, payment_method:payment_method_pix, company: company)
      CompanyPayment.create!(payment_method:payment_method_pix, company: company)
      CompanyPayment.create!(payment_method:payment_method_credit_card, company: company)
      CompanyPayment.create!(payment_method:payment_method_boleto, company: company)

      login_as user
      visit root_path
      click_on 'Meios de Pagamento Escolhidos'

      expect(page).to have_content("Pix #{payment_method_pix.name}")

      end

      it 'and view details' do
        pix = Pix.create!(bank_code: 102, pix_key:12345678909876543210, payment_method:payment_method_pix, company: company)
        CompanyPayment.create!(payment_method:payment_method_pix, company: company)
        CompanyPayment.create!(payment_method:payment_method_credit_card, company: company)
        CompanyPayment.create!(payment_method:payment_method_boleto, company: company)


        login_as user
        visit root_path
        click_on 'Meios de Pagamento Escolhidos'
        click_on ("Pix #{pix.payment_method.name}")
        expect(page).to have_content('10.0')
        expect(page).to have_content('102')
        expect(page).to have_content('12345678909876543210')
        end

        it 'with no chosen payment' do
          login_as user
          visit root_path
          click_on 'Meios de Pagamento Escolhidos'


          expect(page).to have_content('Nenhum Boleto')
          expect(page).to have_content('Nenhum Pix')
          expect(page).to have_content('Nenhum Cartão de Credito')
          end
    end
end
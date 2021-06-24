require 'rails_helper'

describe 'User' do
  let(:company) { Company.create!(cnpj: '12345678910110', corporate_name: 'Codeplay', 
  billing_address: 'Rua x, 420', email: 'admin@codeplay.com.br' )}
  let(:user) {User.create!(email:'x@x.com.br',password: '123456', company: company, role:1)}
  let(:payment_method_pix) {PaymentMethod.create!(name: 'Banco Roxinho', max_fee: 10, percentage_fee:10, category: 'pix')}
  let(:pix) {Pix.create!(bank_code: 102, pix_key:12345678909876543210, payment_method:payment_method_pix, company: company)}
  let(:companypayment_pix) {CompanyPayment.create!(company: company, payment_method: payment_method_pix)}

    describe 'updates' do

    it 'pix successfully' do
      PaymentMethod.create!(name: 'Banco Roxinho', max_fee: 10, percentage_fee:10, category: 'pix')
      Pix.create!(bank_code: 102, pix_key:12345678909876543210, payment_method:payment_method_pix, company: company)
      CompanyPayment.create!(company: company, payment_method: payment_method_pix)

    login_as user, scope: :user
    visit root_path
    click_on 'Meios de Pagamento Escolhidos'
    click_on 'Pix Banco Roxinho'
    click_on 'Editar'
    fill_in 'Código do Banco', with: 103
    fill_in 'Chave Pix', with: 12345678909876543210
    click_on 'Atualizar'

    expect(page).to have_content("Pix Banco Roxinho")
    expect(page).to have_content("Taxa(%): 10.0")
    expect(page).to have_content("Taxa Maxima: R$ 10,00")
    expect(page).to have_content('Código do Banco: 103')
    expect(page).to have_content('Chave Pix: 12345678909876543210')
    

    end
    it 'pix with blank fields' do
      PaymentMethod.create!(name: 'Banco Roxinho', max_fee: 10, percentage_fee:10, category: 'pix')
      Pix.create!(bank_code: 102, pix_key:12345678909876543210, payment_method:payment_method_pix, company: company)
      CompanyPayment.create!(company: company, payment_method: payment_method_pix)

      login_as user, scope: :user
      visit root_path
      click_on 'Meios de Pagamento Escolhidos'
      click_on 'Pix Banco Roxinho'
      click_on 'Editar'
      fill_in 'Código do Banco', with: ''
      fill_in 'Chave Pix', with: ''
      click_on 'Atualizar'
  
      expect(page).to have_content('não pode ficar em branco')
      expect(page).to have_content('não pode ficar em branco')
      end
  end
end

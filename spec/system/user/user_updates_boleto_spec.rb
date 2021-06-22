require 'rails_helper'

describe 'User' do
  let!(:company) { Company.create!(cnpj: '12345678910110', corporate_name: 'Codeplay', 
  billing_address: 'Rua x, 420', email: 'admin@codeplay.com.br' )}
  let(:user) {User.create!(email:'x@x.com.br',password: '123456', company_id: company.id, role:1)}
  let!(:payment_method_boleto) {PaymentMethod.create!(name: 'Banco Roxinho', max_fee: 10, percentage_fee:10, category: 'Boleto')}
  let!(:boleto) {Boleto.create!(bank_code: 102, agency_number:1234, bank_account: 123456, payment_method:payment_method_boleto, company: company)}
  let!(:companypayment1) {CompanyPayment.create!(company: company, payment_method: payment_method_boleto)}

    describe 'updates' do
     it 'boleto successfully' do

    login_as user, scope: :user
    visit root_path
    click_on 'Meios de Pagamento Escolhidos'
    click_on 'Boleto Banco Roxinho'
    click_on 'Editar'
    fill_in 'Código do Banco', with: 103
    fill_in 'Número da Agência', with: 1254545
    fill_in 'Conta Bancária', with: 123456
    click_on 'Atualizar'

    expect(page).to have_content("Boleto Banco Roxinho")
    expect(page).to have_content("Taxa(%): 10.0")
    expect(page).to have_content('Taxa Maxima: R$ 10,00')
    expect(page).to have_content('Número da Agência: 1254545')
    expect(page).to have_content('Código do Banco: 103')
    expect(page).to have_content('Conta Bancária: 123456')
  

    end
    
    it 'boleto with blank fields' do
      login_as user, scope: :user
      visit root_path
      click_on 'Meios de Pagamento Escolhidos'
      click_on 'Boleto Banco Roxinho'
      click_on 'Editar'
      fill_in 'Código do Banco', with: ''
      fill_in 'Número da Agência', with: ''
      fill_in 'Conta Bancária', with: ''
      click_on 'Atualizar'
  
      expect(page).to have_content("não pode ficar em branco")
      expect(page).to have_content("não pode ficar em branco")
      expect(page).to have_content('não pode ficar em branco')

    end
  end
end

require 'rails_helper'

describe 'User' do
    describe 'visit available payment method' do
     it 'successfully' do

      company = Company.create(cnpj: '12345678910110', corporate_name: 'Codeplay', 
      billing_address: 'Rua x, 420', email: 'admin@codeplay.com.br' )
      token = SecureRandom.base64(20)
      user = User.create(email:'x@x.com.br',password: '123456', company_id: company.id)
      boleto = PaymentMethod.create!(name: 'Roxinho', max_fee: 10, percentage_fee:10, category:'Boleto')
      pix = PaymentMethod.create!(name: 'Roxinho', max_fee: 5, percentage_fee:10, category:'Pix')
      user_choosen_boleto = Boleto.create(bank_code: 123, agency_number: 1234, bank_account: 123456789, company_id: company.id, payment_method_id: boleto.id)
      user_choosen_pix = Pix.create(pix_key: token, bank_code: 1234, company_id: company.id, payment_method_id: pix.id)

  login_as user, scope: :user
  visit root_path
    click_on 'Meios de Pagamento Disponiveis'

    expect(page).to have_content("Pix Roxinho")
    expect(page).to have_content("Boleto Roxinho")
    end

    it 'and click on back button' do
      company = Company.create(cnpj: '12345678910110', corporate_name: 'Codeplay', 
      billing_address: 'Rua x, 420', email: 'admin@codeplay.com.br' )
      token = SecureRandom.base64(20)
      user = User.create(email:'x@x.com.br',password: '123456', company_id: company.id)
      boleto = PaymentMethod.create!(name: 'Roxinho', max_fee: 10, percentage_fee:10, category:'Boleto')
      pix = PaymentMethod.create!(name: 'Roxinho', max_fee: 5, percentage_fee:10, category:'Pix')
      user_choosen_boleto = Boleto.create(bank_code: 123, agency_number: 1234, bank_account: 123456789, company_id: company.id, payment_method_id: boleto.id)
      user_choosen_pix = Pix.create(pix_key: token, bank_code: 1234, company_id: company.id, payment_method_id: pix.id)

      login_as user, scope: :user
      visit root_path
      click_on 'Meios de Pagamento Disponiveis'
      click_on 'Voltar'

      expect(current_path).to eq(root_path)
    end
  end
end

require 'rails_helper'

describe 'User' do
  let(:company) {Company.create(cnpj: '12345678910110', corporate_name: 'Codeplay', 
  billing_address: 'Rua x, 420', email: 'admin@codeplay.com.br' )}
  let(:user) {User.create(email:'x@x.com.br',password: '123456', company: company)}
  let(:token)  { SecureRandom.base64(15)}
    describe 'visit available payment method' do
     it 'successfully' do

      boleto = PaymentMethod.create!(name: 'Roxinho', max_fee: 10, percentage_fee:10, category:'boleto')
      pix = PaymentMethod.create!(name: 'Roxinho', max_fee: 5, percentage_fee:10, category:'pix')
      user_choosen_boleto = Boleto.create(bank_code: 123, agency_number: 1234, bank_account: 123456789, company: company, payment_method: boleto)
      user_choosen_pix = Pix.create(pix_key: token, bank_code: 1234, company: company, payment_method: pix)

  login_as user, scope: :user
  visit root_path
    click_on 'Meios de Pagamento Disponiveis'

    expect(page).to have_content("Pix Roxinho")
    expect(page).to have_content("Boleto Roxinho")
    end

    it 'and click on back button' do
      
      boleto = PaymentMethod.create!(name: 'Roxinho', max_fee: 10, percentage_fee:10, category:'boleto')
      pix = PaymentMethod.create!(name: 'Roxinho', max_fee: 5, percentage_fee:10, category:'pix')
      user_choosen_boleto = Boleto.create(bank_code: 123, agency_number: 1234, bank_account: 123456789, company: company, payment_method: boleto)
      user_choosen_pix = Pix.create(pix_key: token, bank_code: 1234, company: company, payment_method: pix)

      login_as user, scope: :user
      visit root_path
      click_on 'Meios de Pagamento Disponiveis'
      click_on 'Voltar'

      expect(current_path).to eq(root_path)
    end
  end
end

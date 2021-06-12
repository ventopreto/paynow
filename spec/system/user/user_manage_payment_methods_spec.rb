require 'rails_helper'

describe 'User' do
    describe 'visit payment method page' do
     it 'successfully' do

      company = Company.create(cnpj: '12345678910110', corporate_name: 'Codeplay', 
      billing_address: 'Rua x, 420', email: 'admin@codeplay.com.br' )
      user = User.create(email:'x@x.com.br',password: '123456', company_id: company.id)
      boleto = PaymentMethod.create!(name: 'Boleto Roxinho', max_fee: 10, percentage_fee:10, category:1)
      cartao = PaymentMethod.create!(name: 'Cartão Roxinho', max_fee: 12, percentage_fee:20, category:2)
      pix = PaymentMethod.create!(name: 'PIX Roxinho', max_fee: 5, percentage_fee:10, category:0)

  login_as user, scope: :user
  visit root_path
  click_on 'Gerenciar Meios de Pagamento'


  expect(page).to have_content('Habilitar um Novo Meio de Pagamento')
    end
  end
end

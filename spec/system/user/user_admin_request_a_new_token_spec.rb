require 'rails_helper'

describe 'User' do
  it 'Admin should request a new token' do
    company = Company.create(cnpj: '12345678910110', corporate_name: 'Codeplay', 
    billing_address: 'Rua x, 420', email: 'admin@codeplay.com.br' )
    user = User.create(email:'x@x.com.br',password: '123456', role:1, company_id: company.id)
    current_token = company.token

    login_as user, scope: :user
    visit root_path
    click_on 'Dados da Empresa'
    click_on 'Gerar Novo Token'

    expect(page).to_not have_content(current_token)
    expect(company.token.size).to eq(28)
    end

    it 'Non admin should not request a new token' do
    company = Company.create(cnpj: '12345678910110', corporate_name: 'Codeplay', 
    billing_address: 'Rua x, 420', email: 'admin@codeplay.com.br' )
    user = User.create(email:'x@x.com.br',password: '123456', role:0, company_id: company.id)

    current_token = company.token

    login_as user, scope: :user
    visit root_path
    click_on 'Dados da Empresa'

    expect(page).to_not have_content('Gerar Novo Token')
    expect(page).to have_content(current_token)
    expect(company.token.size).to eq(28)
  end
end



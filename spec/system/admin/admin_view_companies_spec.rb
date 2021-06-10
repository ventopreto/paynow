require 'rails_helper'

describe 'Admin visit companies page' do
  it 'successfully' do
    admin = Admin.create!(email: 'admin@paynow.com.br', password: '123456')

    empresa = Company.create!(cnpj: 12345678910110, corporate_name: 'Codeplay',
                                                  billing_address: 'Rua x, 420', email: 'x@codeplay.com.br')

    login_as admin, scope: :admin
    visit admin_root_path
    click_on 'Gerenciar Empresas'

    expect(current_path).to eq(admin_companies_path)
    expect(page).to have_content('Codeplay')
    expect(page).to have_content('codeplay.com.br')
  end

  it 'and edit some data' do
    admin = Admin.create!(email: 'admin@paynow.com.br', password: '123456')

    empresa = Company.create!(cnpj: 12345678910110, corporate_name: 'Codplay',
                                                  billing_address: 'Rua z, 420', email: 'x@codplay.com.br')

    login_as admin, scope: :admin
    visit admin_root_path
    click_on 'Gerenciar Empresas'
    click_on 'Codplay'
    click_on 'Editar'
    fill_in "CNPJ", with: '12345678910110'
    fill_in "Razão Social", with: 'Codeplay'
    fill_in "Endereço de faturamento", with: 'Rua x, 420'
    fill_in "E-mail para faturamento", with: 'x@codeplay.com.br'
    click_on 'Atualizar'


    expect(page).to have_content('12345678910110')
    expect(page).to have_content('Codeplay')
    expect(page).to have_content('Rua x, 420')
  end

  it 'and generate a new token' do
    admin = Admin.create!(email: 'admin@paynow.com.br', password: '123456')

    empresa = Company.create!(cnpj: 12345678910110, corporate_name: 'Codplay',
                                                  billing_address: 'Rua z, 420', email: 'x@codplay.com.br')
    token = empresa.token

    login_as admin, scope: :admin
    visit admin_root_path
    click_on 'Gerenciar Empresas'
    click_on 'Codplay'
    click_on 'Gerar Novo Token'

    expect(page).to_not have_content(token)
  end
end
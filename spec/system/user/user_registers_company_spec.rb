require 'rails_helper'

describe 'User' do
  describe 'registers a company' do
      it 'successfully' do
      user = User.create(email:'x@x.com.br',password: '123456')

      login_as user, scope: :user
      visit root_path
      click_on 'Cadastrar Empresa'
      fill_in "CNPJ", with: '12345678910110'
      fill_in "Razão Social", with: 'Codeplay'
      fill_in "Endereço de faturamento", with: 'Rua x, 420'
      fill_in "E-mail para faturamento", with: 'x@x.com.br'
      click_on 'Cadastrar'

      expect(page).to have_content('12345678910110')
      expect(page).to have_content('Codeplay')
      expect(page).to have_content('Rua x, 420')
      expect(page).to have_content('x@x.com.br')
  end

  it 'with blank attributes and fail' do
    user = User.create(email:'x@x.com.br',password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Cadastrar Empresa'
    fill_in "CNPJ", with: ''
    fill_in "Razão Social", with: ''
    fill_in "Endereço de faturamento", with: ''
    fill_in "E-mail para faturamento", with: ''
    click_on 'Cadastrar'


    expect(page).to have_content("não pode ficar em branco")
    expect(page).to have_content("não pode ficar em branco")
    expect(page).to have_content("não pode ficar em branco")
    expect(page).to have_content("não pode ficar em branco")
  end

  it 'using public email and fail' do
    user = User.create(email:'x@x.com.br',password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Cadastrar Empresa'
    fill_in "CNPJ", with: '12345678910110'
    fill_in "Razão Social", with: 'Codeplay'
    fill_in "Endereço de faturamento", with: 'Rua x, 420'
    fill_in "E-mail para faturamento", with: 'x@gmail.com.br'
    click_on 'Cadastrar'


    expect(page).to have_content("não é válido")
    end
  end
end
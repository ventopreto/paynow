require 'rails_helper'

describe 'Visitor' do
  it 'create an user account successfully' do
    visit root_path
    click_on 'Cadastre-se'
    fill_in "Email", with: 'x@x.com.br'
    fill_in "Senha", with: '123456'
    fill_in "Confirmação de senha", with: '123456'
    click_on 'Registrar'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('x@x.com.br')
  end

  it 'fail to create an user account using blank attributes' do
    visit root_path
    click_on 'Cadastre-se'
    fill_in "Email", with: ''
    fill_in "Senha", with: ''
    fill_in "Confirmação de senha", with: ''
    click_on 'Registrar'


    expect(page).to have_content("Email não pode ficar em branco")
    expect(page).to have_content("Senha não pode ficar em branco")
    expect(page).to have_content("Email não é válido")
  end

  it 'fail to create an user account using public email' do
    visit root_path
    click_on 'Cadastre-se'
    fill_in "Email", with: 'x@gmail.com.br'
    fill_in "Senha", with: '123456'
    fill_in "Confirmação de senha", with: '123456'
    click_on 'Registrar'


    expect(page).to have_content("Email não é válido")
  end
end
require 'rails_helper'

describe 'Visitor' do
  describe 'Create An Account'
  it 'successfully' do
    visit root_path
    click_on 'Cadastre-se'
    fill_in "Email", with: 'x@x.com.br'
    fill_in "Senha", with: '123456'
    fill_in "Confirmação de senha", with: '123456'
    click_on 'Registrar'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('x@x.com.br')
  end

  it 'using blank attributes and fail' do
    visit root_path
    click_on 'Cadastre-se'
    fill_in "Email", with: ''
    fill_in "Senha", with: ''
    fill_in "Confirmação de senha", with: ''
    click_on 'Registrar'


    expect(page).to have_content("não pode ficar em branco")
    expect(page).to have_content("não pode ficar em branco")
  end

  it 'using public email and fail' do
    visit root_path
    click_on 'Cadastre-se'
    fill_in "Email", with: 'x@gmail.com.br'
    fill_in "Senha", with: '123456'
    fill_in "Confirmação de senha", with: '123456'
    click_on 'Registrar'


    expect(page).to have_content("não é válido")
  end
    it 'with valid company email domain' do
      company = Company.create(email:'admin@codeplay.com.br', billing_address: 'Rua x, 420',
                                                    corporate_name: 'Codeplay', cnpj:12345678910110)
  
      visit root_path
      click_on 'Cadastre-se'
      fill_in "Email", with: 'employer@codeplay.com.br'
      fill_in "Senha", with: '123456'
      fill_in "Confirmação de senha", with: '123456'
      click_on 'Registrar'
  
      expect(User.last.company_id).to eq(company.id)
      expect(page).to have_content('Meios de Pagamento Disponiveis')
      expect(page).to have_content('Dados da Empresa')
    end
  
    it 'without valid company email domain' do
  
      visit root_path
      click_on 'Cadastre-se'
      fill_in "Email", with: 'employer@codeplay.com.br'
      fill_in "Senha", with: '123456'
      fill_in "Confirmação de senha", with: '123456'
      click_on 'Registrar'
  
      expect(User.last.company_id).to eq(nil)
      expect(page).to_not have_content('Gerenciar Meios de Pagamento')
    end
  end  

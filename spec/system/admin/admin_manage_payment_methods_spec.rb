require 'rails_helper'

describe 'Admin' do
    describe 'visit payment method page' do
     it 'successfully' do

  admin = Admin.create!(email: 'admin@paynow.com.br', password: '123456')

  login_as admin
  visit admin_root_path
  click_on 'Metodos de Pagamento'

  expect(page).to have_content("Metodos de Pagamento")
  expect(page).to have_link("Cadastrar Metodo de Pagamento")
    end

    it 'and create a new one' do
      admin = Admin.create!(email: 'admin@paynow.com.br', password: '123456')

      login_as admin
      visit admin_root_path
      click_on 'Metodos de Pagamento'
      click_on 'Cadastrar Metodo de Pagamento'


      fill_in "Nome", with: 'Pisa'
      fill_in "Taxa por cobrança em %", with: 2.5
      fill_in "Taxa máxima em reais", with: 30
      attach_file 'Icon', Rails.root + 'spec/fixtures/cartao_icon.png'
      click_on 'Criar'
      
      expect(page).to have_content("Pisa")
      expect(page).to have_content("2.5%")
      expect(page).to have_content("R$ 30,00")
      expect(page).to have_css("img[src*='cartao_icon.png']")

    end
    it 'and attributes cannot be blank ' do
      admin = Admin.create!(email: 'admin@paynow.com.br', password: '123456')

      login_as admin
      visit admin_root_path
      click_on 'Metodos de Pagamento'
      click_on 'Cadastrar Metodo de Pagamento'


      fill_in "Nome", with: ''
      fill_in "Taxa por cobrança em %", with: ''
      fill_in "Taxa máxima em reais", with: ''
      attach_file 'Icon', Rails.root + 'spec/fixtures/cartao_icon.png'
      click_on 'Criar'
      
      expect(page).to have_content('não pode ficar em branco', count: 3)

    end

  end

  it 'visited by unauthorized user' do
    visit admin_payment_methods_path

    expect(current_path).to eq(new_admin_session_path)
  end
end
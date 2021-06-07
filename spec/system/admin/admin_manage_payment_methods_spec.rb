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

    it 'and create a new payment method' do
      admin = Admin.create!(email: 'admin@paynow.com.br', password: '123456')

      login_as admin
      visit admin_root_path
      click_on 'Metodos de Pagamento'
      click_on 'Cadastrar Metodo de Pagamento'

      expect(current_path).to eq(new_admin_payment_path)
      expect(page).to have_content("Nome")
      #expect(page).to have_content("Icone")
      expect(page).to have_content("Taxa por cobrança em %")
      expect(page).to have_content("Taxa máxima em reais")
      expect(page).to have_button("Criar")
      
    end
  end


  it 'visited by unauthorized user' do
    visit admin_payments_path

    expect(current_path).to eq(new_admin_session_path)
  end
end
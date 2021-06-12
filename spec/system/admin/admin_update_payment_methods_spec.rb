require 'rails_helper'

describe 'Admin' do
    describe 'updates payment method' do
     it 'successfully' do
      admin = Admin.create!(email: 'admin@paynow.com.br', password: '123456')
      PaymentMethod.create!(name: 'Boleto', max_fee: 10, percentage_fee:10, category:1)

      login_as admin, scope: :admin
      visit admin_root_path
      click_on 'Metodos de Pagamento'
      click_on 'Boleto'
      click_on 'Editar'

      fill_in "Nome", with: 'Mestre Card'
      fill_in "Taxa por cobrança em %", with: 5.5
      fill_in "Taxa máxima em reais", with: 40
      select 'Cartão'
      click_on 'Atualizar'

      expect(page).to have_content('Mestre Card')
      expect(page).to have_content('5.5%')
      expect(page).to have_content('R$ 40,00')
      expect(page).to have_css("img[src*='cartao_icon.png']")
     end

     it 'and attributes cannot be blank' do
      admin = Admin.create(email: 'admin@paynow.com.br', password: '123456')

      PaymentMethod.create!(name: 'Boleto', max_fee: 10, percentage_fee:10, category:1)

      login_as admin, scope: :admin
      visit admin_root_path
      click_on 'Metodos de Pagamento'
      click_on 'Boleto'
      click_on 'Editar'

      fill_in "Nome", with: ''
      fill_in "Taxa por cobrança em %", with: ''
      fill_in "Taxa máxima em reais", with: ''
      click_on 'Atualizar'

      expect(page).to have_content('não pode ficar em branco' , count: 3)
     end
  end
end
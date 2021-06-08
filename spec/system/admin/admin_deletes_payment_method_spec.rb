require 'rails_helper'

describe 'Admin' do
    describe 'deletes payment method' do
     it 'successfully' do
      admin = Admin.create!(email: 'admin@paynow.com.br', password: '123456')
      PaymentMethod.create(name: 'Boleto', max_fee: 10, percentage_fee:10)

      login_as admin
      visit admin_root_path
      click_on 'Metodos de Pagamento'
      click_on 'Boleto'

      expect {click_on 'Excluir'}.to change {PaymentMethod.count}.by(-1)
     end
  end
end
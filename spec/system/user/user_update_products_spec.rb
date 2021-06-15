require 'rails_helper'

describe User do
  let(:codeplay) { Company.create(cnpj: '12345678910110', corporate_name: 'Codeplay', 
  billing_address: 'Rua x, 420', email: 'admin@codeplay.com.br' )}
  let(:user) {User.create(email:'x@x.com.br',password: '123456', company: codeplay)}
  let!(:product1) {Product.create(name: 'Curso de Rails', price: 420, company: codeplay)}
  let!(:product2) {Product.create(name: 'Curso de Java', price: 300, company: codeplay)}
  describe 'updates registered products' do
    it 'successfully' do

      login_as user
      visit root_path
      click_on 'Dados da Empresa'
      click_on 'Curso de Rails'
      click_on 'Editar'

      fill_in 'Nome', with: 'Curso de Ruby on Rails'
      fill_in 'Preço', with: '600'
      click_on 'Atualizar'

      expect(page).to have_content('Curso de Ruby on Rails')
      expect(page).to have_content('R$ 600,00')

      end

      it 'fail' do

        login_as user
        visit root_path
        click_on 'Dados da Empresa'
        click_on 'Curso de Rails'
        click_on 'Editar'
  
        fill_in 'Nome', with: ''
        fill_in 'Preço', with: ''
        click_on 'Atualizar'
  
        expect(page).to have_content('não pode ficar em branco')
        expect(page).to have_content('não pode ficar em branco')
  
        end
    end
end
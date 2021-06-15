require 'rails_helper'

describe User do
  let(:company) { Company.create(cnpj: '12345678910110', corporate_name: 'Codeplay', 
  billing_address: 'Rua x, 420', email: 'admin@codeplay.com.br' )}
  let(:user) {User.create(email:'x@x.com.br',password: '123456', company_id: company.id)}
  describe 'Register Product' do
    it 'successfully' do

      login_as user
      visit root_path
      click_on 'Dados da Empresa'
      click_on 'Cadastrar Produto'

      fill_in "Nome", with: 'Curso de Rails'
      fill_in "Preço", with: 420
      fill_in 'Desconto', with: 10
      click_on 'Criar'

      expect(page).to have_content('Curso de Rails')
      expect(page).to have_content('R$ 420,00')
      expect(page).to have_content('10%')

      end

      it 'successfully without discount' do

        login_as user
        visit root_path
        click_on 'Dados da Empresa'
        click_on 'Cadastrar Produto'
  
        fill_in "Nome", with: 'Curso de Rails'
        fill_in "Preço", with: 420
        fill_in 'Desconto', with: ''
        click_on 'Criar'
  
        expect(page).to have_content('Curso de Rails')
        expect(page).to have_content('R$ 420,00')
  
        end

      it 'fail with blank attributes' do

        login_as user
        visit root_path
        click_on 'Dados da Empresa'
        click_on 'Cadastrar Produto'

        fill_in "Nome", with: ''
        fill_in "Preço", with: ''
        click_on 'Criar'
  
        expect(page).to have_content('não pode ficar em branco')
        expect(page).to have_content('não pode ficar em branco')
        
        end
    end
end
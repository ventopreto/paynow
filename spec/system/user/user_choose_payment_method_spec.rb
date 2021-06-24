require 'rails_helper'

describe 'User' do
  let(:user) {User.create(email:'x@x.com.br',password: '123456', company: codeplay)}
  let(:codeplay) { Company.create(cnpj: '12345678910110', corporate_name: 'Codeplay', 
  billing_address: 'Rua x, 420', email: 'admin@codeplay.com.br' )}
  let(:user) {User.create(email:'x@x.com.br',password: '123456', company: codeplay)}
  let(:token) {SecureRandom.base64(15)}
    describe 'choose payment' do
     it 'boleto successfully' do

      PaymentMethod.create!(name: 'Banco Roxinho', max_fee: 10, percentage_fee:10, category: 'boleto')
   
    login_as user, scope: :user
    visit root_path
    click_on 'Meios de Pagamento Disponiveis'
    click_on 'Boleto Banco Roxinho'
    click_on 'Adicionar esse meio de pagamento'
    fill_in 'Código do Banco', with: 103
    fill_in 'Número da Agência', with: 1254545
    fill_in 'Conta Bancária', with: 123456
    click_on 'Criar'

    expect(page).to have_content("Boleto Banco Roxinho")
    expect(page).to have_content("Taxa(%): 10.0")
    expect(page).to have_content('Taxa Maxima: R$ 10,00')
    expect(page).to have_content('Número da Agência: 1254545')
    expect(page).to have_content('Código do Banco: 103')
    expect(page).to have_content('Conta Bancária: 123456')
  
    end

    it 'boleto with blank fields' do

      PaymentMethod.create!(name: 'Banco Roxinho', max_fee: 10, percentage_fee:10, category: 'boleto')

      login_as user, scope: :user
      visit root_path
      click_on 'Meios de Pagamento Disponiveis'
      click_on 'Boleto Banco Roxinho'
      click_on 'Adicionar esse meio de pagamento'
      fill_in 'Código do Banco', with: ''
      fill_in 'Número da Agência', with: ''
      fill_in 'Conta Bancária', with: ''
      click_on 'Criar'
  
      expect(page).to have_content("não pode ficar em branco")
      expect(page).to have_content("não pode ficar em branco")
      expect(page).to have_content('não pode ficar em branco')

    end

    it 'pix successfully' do
      PaymentMethod.create!(name: 'Banco Roxinho', max_fee: 5, percentage_fee:10, category: 'pix')
    login_as user, scope: :user
    visit root_path
    click_on 'Meios de Pagamento Disponiveis'
    click_on 'Pix Banco Roxinho'
    click_on 'Adicionar esse meio de pagamento'
    fill_in 'Código do Banco', with: 103
    fill_in 'Chave Pix', with: 12345678909876543210
    click_on 'Criar'

    expect(page).to have_content("Nome: Pix Banco Roxinho")
    expect(page).to have_content("Taxa(%): 10.0")
    expect(page).to have_content("Taxa Maxima: R$ 5,00")
    expect(page).to have_content('Código do Banco: 103')
    expect(page).to have_content('Chave Pix: 12345678909876543210')
    
    end

    it 'pix with blank fields' do
      PaymentMethod.create!(name: 'Banco Roxinho', max_fee: 5, percentage_fee:10, category: 'pix')
      login_as user, scope: :user
      visit root_path
      click_on 'Meios de Pagamento Disponiveis'
      click_on 'Pix Banco Roxinho'
      click_on 'Adicionar esse meio de pagamento'
      fill_in 'Código do Banco', with: ''
      fill_in 'Chave Pix', with: ''
      click_on 'Criar'
  
      expect(page).to have_content('não pode ficar em branco')
      expect(page).to have_content('não pode ficar em branco')
    end

    it 'creditcard successfully' do
      PaymentMethod.create!(name: 'Nubank', max_fee: 5, percentage_fee:10, category: 'credit_card')
      login_as user, scope: :user
      visit root_path
      click_on 'Meios de Pagamento Disponiveis'
      click_on 'Cartão Nubank'
      click_on 'Adicionar esse meio de pagamento'
      fill_in 'Código Alfanumérico', with: 12345678901234567890
      click_on 'Criar'
  
      expect(page).to have_content("Nome: Cartão Nubank")
      expect(page).to have_content("Taxa(%): 10.0")
      expect(page).to have_content("Taxa Maxima: R$ 5,00")
      expect(page).to have_content("Código Alfanumérico: 123456789012345678")

      end

      it 'credit card with blank fields' do
        PaymentMethod.create!(name: 'Nubank', max_fee: 10, percentage_fee:10, category: 'credit_card')
        login_as user, scope: :user
        visit root_path
        click_on 'Meios de Pagamento Disponiveis'
        click_on 'Cartão Nubank'
        click_on 'Adicionar esse meio de pagamento'
        fill_in 'Código Alfanumérico', with: ''
        click_on 'Criar'
        save_page
    
        expect(page).to have_content('não pode ficar em branco')
        
      end
  end
end

require 'rails_helper'

describe 'Back button' do
  let!(:user) {user = User.create(email:'x@x.com.br',password: '123456', role:1, company_id: company.id)}
  let!(:company) {    company = Company.create(cnpj: '12345678910110', corporate_name: 'Codeplay', 
  billing_address: 'Rua x, 420', email: 'admin@codeplay.com.br' )}
  let!(:cartao) {PaymentMethod.create!(name: 'Nubank', max_fee: 5, percentage_fee:10, category:'Cartão')}
  let!(:boleto) {PaymentMethod.create!(name: 'Nubank', max_fee: 5, percentage_fee:10, category:'Boleto')}
  let!(:pix) {PaymentMethod.create!(name: 'Nubank', max_fee: 5, percentage_fee:10, category:'Pix')}


  it 'of company page should redirect to root' do

    login_as user, scope: :user
    visit root_path
    click_on 'Dados da Empresa'
    click_on 'Voltar'


    expect(current_path).to eq(root_path)
    end

    it 'of available payments page should redirect to root' do
      login_as user, scope: :user
      visit root_path
      click_on 'Meios de Pagamento Disponiveis'
      click_on 'Voltar'

      expect(current_path).to eq(root_path)
  end

  it 'of available payments details should redirect to root' do
    login_as user, scope: :user
    visit root_path
    click_on 'Meios de Pagamento Disponiveis'
    click_on 'Cartão Nubank'
    click_on 'Voltar'

    expect(current_path).to eq(user_payment_methods_path)

  end


  it 'of chosen payment methods page should redirect to root' do
    login_as user, scope: :user
    visit root_path
    click_on 'Meios de Pagamento Escolhidos'
    click_on 'Voltar'

    expect(current_path).to eq(root_path)

  end

  it 'of chosen payment methods page should redirect to root' do
    login_as user, scope: :user
    visit root_path
    click_on 'Meios de Pagamento Escolhidos'
    click_on 'Voltar'

    expect(current_path).to eq(root_path)

    end

    it 'of credit card details should redirect to chosen payments page' do
      CreditCard.create!(token: 123456789, company_id: company.id, payment_method_id:cartao.id)
      login_as user, scope: :user
      visit root_path
      click_on 'Meios de Pagamento Escolhidos'
      click_on 'Cartão Nubank'
      click_on 'Voltar'
  
      expect(current_path).to eq(user_company_chosen_payments_path(company.id))
  
      end

      it 'of boleto details should redirect to chosen payments page' do
        Boleto.create!(bank_code: 103, agency_number: 1254, bank_account: 12345678, company_id: company.id, payment_method_id:boleto.id)
        login_as user, scope: :user
        visit root_path
        click_on 'Meios de Pagamento Escolhidos'
        click_on 'Boleto Nubank'
        click_on 'Voltar'
        expect(current_path).to eq(user_company_chosen_payments_path(company.id))
        end

        it 'of pix details should redirect to chosen payments page' do
          Pix.create!(bank_code: 103,pix_key: 12345678, company_id: company.id, payment_method_id:pix.id)
          login_as user, scope: :user
          visit root_path
          click_on 'Meios de Pagamento Escolhidos'
          click_on 'Pix Nubank'
          click_on 'Voltar'
          expect(current_path).to eq(user_company_chosen_payments_path(company.id))
          end
  end




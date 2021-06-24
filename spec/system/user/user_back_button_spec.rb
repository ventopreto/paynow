require 'rails_helper'

describe 'Back button' do
  let!(:user) {user = User.create(email:'x@x.com.br',password: '123456', role:1, company: company)}
  let!(:company) { company = Company.create(cnpj: '12345678910110', corporate_name: 'Codeplay', 
  billing_address: 'Rua x, 420', email: 'admin@codeplay.com.br' )}
  let!(:payment_method_credit_card) {PaymentMethod.create!(name: 'Nubank', max_fee: 5, percentage_fee:10, category:2)}
  let!(:payment_method_boleto) {PaymentMethod.create!(name: 'Nubank', max_fee: 5, percentage_fee:10, category:'boleto')}
  let!(:payment_method_pix) {PaymentMethod.create!(name: 'Nubank', max_fee: 5, percentage_fee:10, category:'pix')}


  it 'of company page should redirect to root' do

    login_as user, scope: :user
    visit root_path
    click_on 'Dados da Empresa'
    click_on 'Voltar'


    expect(current_path).to eq(root_path)
    end

    it 'of company products page should redirect to company page' do
      Product.create!(name: 'Curso de Rails',price: 420, company: company)
      login_as user, scope: :user
      visit root_path
      click_on 'Dados da Empresa'
      click_on 'Curso de Rails'
      click_on 'Voltar'
      expect(current_path).to eq(user_company_path(company.token))
      end

      it 'of product form should redirect to root path' do
        Product.create!(name: 'Curso de Rails',price: 420, company: company)
        login_as user, scope: :user
        visit root_path
        click_on 'Dados da Empresa'
        click_on 'Curso de Rails'
        click_on 'Editar'
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

    it 'of credit card details should redirect to chosen payments page' do
      CreditCard.create!(token:12345678909876543210, payment_method:payment_method_credit_card, company: company)
      CompanyPayment.create!(company:company, payment_method: payment_method_credit_card)
      Pix.create!(bank_code: 102, pix_key:12345678909876543210, payment_method:payment_method_pix, company: company)
      
      login_as user, scope: :user
      visit root_path
      click_on 'Meios de Pagamento Escolhidos'
      click_on "Cartão #{payment_method_credit_card.name}"
      click_on 'Voltar'
  
      expect(current_path).to eq(user_company_chosen_payments_path(company.token))
  
      end

      it 'of credit card form should redirect to root path' do
        Boleto.create!(bank_code: 103, agency_number: 1254, bank_account: 12345678, company: company, payment_method:payment_method_boleto)
        login_as user, scope: :user
        visit root_path
        click_on 'Meios de Pagamento Escolhidos'
        click_on 'Boleto Nubank'
        click_on 'Editar'
        click_on 'Voltar'
    
        expect(current_path).to eq(root_path)
    
        end

      it 'of payment_method_boleto form should redirect to root path' do
        Boleto.create!(bank_code: 103, agency_number: 1254, bank_account: 12345678, company: company, payment_method:payment_method_boleto)
        login_as user, scope: :user
        visit root_path
        click_on 'Meios de Pagamento Escolhidos'
        click_on 'Boleto Nubank'
        click_on 'Editar'
        click_on 'Voltar'
        expect(current_path).to eq(root_path)
        end

        it 'of boleto details should redirect to chosen payments page' do
          Boleto.create!(bank_code: 103, agency_number: 1254, bank_account: 12345678, company: company, payment_method:payment_method_boleto)
          login_as user, scope: :user
          visit root_path
          click_on 'Meios de Pagamento Escolhidos'
          click_on 'Boleto Nubank'
          click_on 'Voltar'
          expect(current_path).to eq(user_company_chosen_payments_path(company.token))
          end

        it 'of payment_method_ details should redirect to chosen payments page' do
          Pix.create!(bank_code: 103, pix_key: 12345678909876543210, company: company, payment_method:payment_method_pix)
          login_as user, scope: :user
          visit root_path
          click_on 'Meios de Pagamento Escolhidos'
          click_on 'Pix Nubank'
          click_on 'Voltar'
          expect(current_path).to eq(user_company_chosen_payments_path(company.token))
          end

          it 'of payment_method_ form should redirect to root path' do
            Pix.create!(bank_code: 103,pix_key: 12345678909876543210, company: company, payment_method:payment_method_pix)
            login_as user, scope: :user
            visit root_path
            click_on 'Meios de Pagamento Escolhidos'
            click_on 'Pix Nubank'
            click_on 'Editar'
            click_on 'Voltar'
            expect(current_path).to eq(root_path)
            end
  end




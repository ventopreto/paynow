require 'rails_helper'

describe 'Charge' do
  let(:product1)  {Product.create(name: 'Gamepass PC', price: 30, company: company1)}
  let(:product2) {Product.create(name: 'Gamepass Ultimate', price: 45, company: company1)}
  let(:company1) {Company.create(cnpj: 12345678910110, corporate_name: 'Xbox', 
  billing_address: 'Rua x, 420', email: 'admin@xbox.com.br' )}
  let!(:payment_method_boleto) {PaymentMethod.create!(name: 'Banco Roxinho', max_fee: 10, percentage_fee:10, category: 'Boleto')}
  let!(:payment_method_credit_card) {PaymentMethod.create!(name: 'Banco Roxinho', max_fee: 10, percentage_fee:10, category: 2)}
  let!(:payment_method_pix) {PaymentMethod.create!(name: 'Banco Roxinho', max_fee: 10, percentage_fee:10, category: 'Pix')}
  let(:boleto) {Boleto.create!(bank_code: 102, agency_number:1234, bank_account: 123456, payment_method:payment_method_boleto, company: company1)}
  let(:pix) {Pix.create!(bank_code: 102, pix_key:12345678909876543210, payment_method:payment_method_pix, company: company1)}
  let(:credit_card) {CreditCard.create!(token:12345678909876543210, payment_method:payment_method_credit_card, company: company1)}
  let(:companypayment1) {CompanyPayment.create!(company: company1, payment_method: payment_method_boleto)}
  let(:end_user1) {EndUser.create!(cpf:12345678910, fullname:'Fulano Sicrano')}
  let(:user1) { User.create(email:'x@x.com.br',password: '123456', role:1, company_id: company1.id)}
  it 'create payment receipt successfully' do
    charge = Charge.create!(payment_category: 'Boleto', address: 'Rua x 420', boleto: boleto, end_user:end_user1, company: company1, 
    payment_method: boleto.payment_method, product: product1, original_value: product1.price,
     value_with_discount: product1.price)

    company = company1
    user = user1
    login_as user, scope: :user
    visit root_path
    click_on 'Dados da Empresa'
    click_on 'Ver Cobranças'
    click_on "Atualizar #{charge.token}"

    select '05 Cobrança efetivada com sucesso', from: 'Status'
    fill_in 'Data efetiva do pagamento', with: Date.today
    fill_in 'Codigo de Autorização', with: 'khasdkhakhdhk'
    click_on 'Atualizar'

    expect(Charge.first.effective_payment_date).to eq(Date.today)
    expect(Charge.first.status).to eq("aprovada")
    expect(Charge.count).to eq(1)
    
    end

      it 'Admin should change charge status to reject option 1' do
        charge = Charge.create!(payment_category: 'Boleto', address: 'Rua x 420', boleto: boleto, end_user:end_user1, company: company1, 
        payment_method: boleto.payment_method, product: product1, original_value: product1.price,
         value_with_discount: product1.price)
    
        company = company1
        user = user1
        login_as user, scope: :user
        visit root_path
        click_on 'Dados da Empresa'
        click_on 'Ver Cobranças'
        click_on "Atualizar #{charge.token}"
    
        select '09 Cobrança recusada por falta de créditos', from: 'Status'
        fill_in 'Data da tentativa', with: Date.today
        click_on 'Atualizar'
    
        expect(Charge.first.payment_attempt_date).to eq(Date.today)
        expect(Charge.first.status).to eq("pendente")
        expect(Charge.first.last_status).to eq("09 Cobrança recusada por falta de créditos")
        expect(Charge.count).to eq(1)
        end
        
        it 'Admin should change charge status to reject option 2' do
          charge = Charge.create!(payment_category: 'Boleto', address: 'Rua x 420', boleto: boleto, end_user:end_user1, company: company1, 
          payment_method: boleto.payment_method, product: product1, original_value: product1.price,
           value_with_discount: product1.price)
      
          company = company1
          user = user1
          login_as user, scope: :user
          visit root_path
          click_on 'Dados da Empresa'
          click_on 'Ver Cobranças'
          click_on "Atualizar #{charge.token}"
      
          select '10 Cobrança recusada por dados incorretos para cobrança', from: 'Status'
          fill_in 'Data da tentativa', with: Date.today
          click_on 'Atualizar'
      
          expect(Charge.first.payment_attempt_date).to eq(Date.today)
          expect(Charge.first.status).to eq("pendente")
          expect(Charge.first.last_status).to eq("10 Cobrança recusada por dados incorretos para cobrança")
          expect(Charge.count).to eq(1)
          end

          it 'Admin should change charge status to reject option 3' do
            charge = Charge.create!(payment_category: 'Boleto', address: 'Rua x 420', boleto: boleto, end_user:end_user1, company: company1, 
            payment_method: boleto.payment_method, product: product1, original_value: product1.price,
             value_with_discount: product1.price)
        
            company = company1
            user = user1
            login_as user, scope: :user
            visit root_path
            click_on 'Dados da Empresa'
            click_on 'Ver Cobranças'
            click_on "Atualizar #{charge.token}"
        
            select '11 Cobrança recusada sem motivo especificado', from: 'Status'
            fill_in 'Data da tentativa', with: Date.today
            click_on 'Atualizar'
        
            expect(Charge.first.payment_attempt_date).to eq(Date.today)
            expect(Charge.first.status).to eq("pendente")
            expect(Charge.first.last_status).to eq("11 Cobrança recusada sem motivo especificado")
            expect(Charge.count).to eq(1)
            end
end



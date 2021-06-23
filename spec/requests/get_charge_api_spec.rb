require 'rails_helper'

describe 'Charge API' do
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
  let!(:charge) {Charge.create!(payment_category: 'Boleto', address: 'Rua x 420', boleto: boleto, end_user:end_user1, company: company1, 
  payment_method: boleto.payment_method, product: product1, original_value: product1.price,
   value_with_discount: product1.price, billing_due_date: Date.today.strftime('%d %m %Y'))}
  context 'GET /api/v1/charges' do
    it 'should get a charge by payment category ' do

      get '/api/v1/charges', 
      params:{
        charge:{
           payment_category:boleto.payment_method.category
         }
     }
     
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(response.body).to include("30.0")
      expect(response.body).to include("30.0")
      expect(response.body).to include("1")
      expect(response.body).to include("1")
      expect(response.body).to include("Rua x 420")
      expect(response.body).to include(Date.today.strftime('%d %m %Y'))

    end
    it 'should get a charge by billing due date ' do
        get '/api/v1/charges', 
        params:{
          charge:{
            billing_due_date:Date.today.strftime('%d %m %Y')
           }
       }
       
        expect(response).to have_http_status(200)
        expect(response.content_type).to include('application/json')
        expect(response.body).to include("30.0")
        expect(response.body).to include("30.0")
        expect(response.body).to include("1")
        expect(response.body).to include("1")
        expect(response.body).to include("Rua x 420")
        expect(response.body).to include(Date.today.strftime('%d %m %Y'))
      end

      it 'billing due date not found' do
        get '/api/v1/charges', 
        params:{
          charge:{
            billing_due_date: 3.days.from_now
           }
       }
       
        expect(response).to have_http_status(404)

      end

      it 'payment category not found' do
        get '/api/v1/charges', 
        params:{
          charge:{
            payment_category: 3.days.from_now
           }
       }
       
        expect(response).to have_http_status(404)

      end

      it 'should not get a charge by billing due date with missing params' do
        get '/api/v1/charges', 
        params:{
          charge:{
            billing_due_date:''
           }
       }
       
        expect(response).to have_http_status(412)
        expect(response.body).to include("Parâmetros inválidos")

      end

      it 'should not get a charge by payment category with missing params' do
        get '/api/v1/charges', 
        params:{
          charge:{
            payment_category:''
           }
       }
       
        expect(response).to have_http_status(412)
        expect(response.body).to include("Parâmetros inválidos")

      end

      it 'should not get a charge by payment category with missing params' do
        get '/api/v1/charges', 
        params:{
          charge:{
            payment_category:''
           }
       }
       
        expect(response).to have_http_status(412)
        expect(response.body).to include("Parâmetros inválidos")

      end
  end

  def parsed_body
    JSON.parse(response.body)
    end
end
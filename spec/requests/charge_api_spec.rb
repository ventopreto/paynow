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
  context 'POST /api/v1/charges' do
    it 'should create a charge with boleto' do
    end_user = end_user1
      product = product1
      companypayment = companypayment1
      company = company1
      post '/api/v1/charges', 
      
      params:{
        charge:{
           end_user_token: end_user.token,
           product_token:product.token,
           company_token:company.token,
           payment:boleto.id,
           address: "Rua tal 42",
           payment_category:boleto.payment_method.category
         }
     }
     
      expect(response).to have_http_status(201)
      expect(Charge.count).to eq(1)
      expect(response.content_type).to include('application/json')
      expect(response.parsed_body["end_user_id"]).to eq(1)
      expect(response.parsed_body["original_value"]).to eq("30.0")
      expect(response.parsed_body["value_with_discount"]).to eq("27.0")
      expect(response.parsed_body["boleto_id"]).to eq(1)
      expect(response.parsed_body["payment_method_id"]).to eq(1)
      expect(Charge.last.product).to eq(product)
    end


    it 'should create a charge with pix' do
      end_user = end_user1
        product = product1
        companypayment = companypayment1
        company = company1
        post '/api/v1/charges', 
        
        params:{
          charge:{
             end_user_token: end_user.token,
             product_token:product.token,
             company_token:company.token,
             payment:pix.id,
             payment_category:pix.payment_method.category
           }
       }

       
        expect(response).to have_http_status(201)
        expect(Charge.count).to eq(1)
        expect(response.content_type).to include('application/json')
        expect(response.parsed_body["end_user_id"]).to eq(1)
        expect(response.parsed_body["original_value"]).to eq("30.0")
        expect(response.parsed_body["value_with_discount"]).to eq("28.5")
        expect(response.parsed_body["pix_id"]).to eq(1)
        expect(response.parsed_body["payment_method_id"]).to eq(3)
        expect(Charge.last.product).to eq(product)
      end

      it 'should create a charge with credit card' do
        end_user = end_user1
          product = product1
          companypayment = companypayment1
          company = company1
          post '/api/v1/charges', 
          
          params:{
            charge:{
               end_user_token: end_user.token,
               product_token:product.token,
               company_token:company.token,
               payment:credit_card.id,
               cvv: 123,
               cardholder_name: 'Fulano Sicrano',
               credit_card_number: 1234567890123456,
               payment_category:credit_card.payment_method.category
             }
         }
         
          expect(response).to have_http_status(201)
          expect(Charge.count).to eq(1)
          expect(response.content_type).to include('application/json')
          expect(response.parsed_body["end_user_id"]).to eq(1)
          expect(response.parsed_body["original_value"]).to eq("30.0")
          expect(response.parsed_body["value_with_discount"]).to eq("30.0")
          expect(response.parsed_body["credit_card_id"]).to eq(1)
          expect(response.parsed_body["payment_method_id"]).to eq(2)
          expect(Charge.last.product).to eq(product)
        end

      it 'should not create a charge with invalid parameters' do
        product = product1
        companypayment = companypayment1
        company = company1
        post '/api/v1/charges'
          {}
          expect(response).to have_http_status(412)
          expect(response.body).to include('Parâmetros inválidos')
    end

    it 'should not create a charge with invalid parameters' do
      product = product1
      companypayment = companypayment1
      company = company1

      post '/api/v1/charges', 
      params:{
        charge:{
           product_token:product.token,
           company_token:company.token,
           payment:boleto.id,
           address: "Rua tal 42",
           payment_category:boleto.payment_method.category
  
         }
     }

    expect(response).to have_http_status(422)
    expect(response.body).to include('não pode ficar em branco')
    end
  end

  def parsed_body
    JSON.parse(response.body)
  end
end
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

  context 'POST /api/v1/charge' do
    it 'should create a charge' do
      product = product1
      companypayment = companypayment1
      company = company1
      post '/api/v1/end_users', params: {charge:{cpf: 12345678910 , fullname: 'Mateus Bruno Abreu'},
                                                             product_token: product.token, company_token: company.token, 
                                                             payment: boleto.id, payment_category: boleto.payment_method.category}

      expect(response).to have_http_status(201)
    end

      it 'should not create a charge with invalid parameters' do
        product = product1
        companypayment = companypayment1
        company = company1
        post '/api/v1/end_users'
          {}
          expect(response).to have_http_status(412)
          expect(response.body).to include('Parâmetros inválidos')
    end

    it 'should not create a charge with invalid parameters' do
      product = product1
      companypayment = companypayment1
      company = company1

      post '/api/v1/end_users', params: {charge:{cpf: 12345678910 , fullname: 'Mateus Bruno Abreu'},
      product_token: product.token, company_token: company.token, 
      payment: boleto.id, payment_category: boleto.payment_method.category}

    expect(response).to have_http_status(422)
    expect(response.body).to include('não pode ficar em branco')
    end
  end
end
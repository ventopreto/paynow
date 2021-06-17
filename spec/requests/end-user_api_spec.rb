require 'rails_helper'

describe 'End User API' do
  context 'POST /api/v1/end_user' do
    it 'should create a end user' do
      company = Company.create(cnpj: 12345678910110, corporate_name: 'Xbox', 
      billing_address: 'Rua x, 420', email: 'admin@xbox.com.br' )
      post '/api/v1/end_users', params: {end_user:{cpf: 12345678910 , fullname: 'Mateus Bruno Abreu'}, company_token: company.token}
  
      expect(response).to have_http_status(201)
    end

    it 'should not create a end user with missing params' do
      company = Company.create(cnpj: 12345678910110, corporate_name: 'Xbox', 
      billing_address: 'Rua x, 420', email: 'admin@xbox.com.br' )
      post '/api/v1/end_users', params: {end_user:{cpf: 12345678910}, company_token: company.token}
      
      expect(response).to have_http_status(422)
      expect(response.body).to include('não pode ficar em branco')
    end

    it 'should not create a end user with invalid parameters' do
      post '/api/v1/end_users'
      {}
      expect(response).to have_http_status(412)
      expect(response.body).to include('Parâmetros inválidos')

    end

    it 'should not create a duplicated end_user' do
      EndUser.create(fullname: 'Mateus Bruno Abreu', cpf: 12345678910)
      company = Company.create(cnpj: 12345678910110, corporate_name: 'Xbox', 
      billing_address: 'Rua x, 420', email: 'admin@xbox.com.br' )
      
      post '/api/v1/end_users', params: {end_user:{cpf: 12345678910 , fullname: 'Mateus Bruno Abreu'}, company_token: company.token}
      expect(response).to have_http_status(201)
      expect(EndUser.count).to eq(1)

    end
  end
end
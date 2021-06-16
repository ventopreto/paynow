require 'rails_helper'

describe 'End User API' do
  context 'POST /api/v1/end_user' do
    it 'should create a end user' do
      post '/api/v1/end_users', params: {end_user:{cpf: '12345678910', fullname: 'Mateus Bruno Abreu'}}

      expect(response).to have_http_status(201)
    end

    it 'should not create a end user with missing params' do
      post '/api/v1/end_users', params: {end_user:{cpf: '12345678910'}}

      expect(response).to have_http_status(422)
      expect(response.body).to include('não pode ficar em branco')
      

    end

    it 'should not create a end user with invalid parameters' do
      post '/api/v1/end_users'

      expect(response).to have_http_status(412)
      expect(response.body).to include('Parâmetros inválidos')

    end
  end
end
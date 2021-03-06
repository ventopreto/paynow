require 'rails_helper'

describe Company do
  describe 'Validates' do
      it 'attributes cannot be blank' do
        codeplay = Company.new()

        codeplay.valid?

        expect(codeplay.errors[:email]).to include('não pode ficar em branco')
        expect(codeplay.errors[:billing_address]).to include('não pode ficar em branco')
        expect(codeplay.errors[:cnpj]).to include('não pode ficar em branco')
        expect(codeplay.errors[:corporate_name]).to include('não pode ficar em branco')
        expect(codeplay).to_not be_valid
    end

    it 'success' do
      codeplay =Company.create(email: 'codeplay@codeplay.com.br', cnpj: 12345678910110, 
      billing_address:'Rua Tal, 50, Centro',
      corporate_name: 'codeplay ltda')

      codeplay.valid?

      expect(codeplay.email).to eq('codeplay@codeplay.com.br')
      expect(codeplay.billing_address).to eq('Rua Tal, 50, Centro')
      expect(codeplay.cnpj).to eq(12345678910110)
      expect(codeplay.corporate_name).to eq('codeplay ltda')
      expect(codeplay.token.size).to eq(20)
      expect(codeplay).to be_valid
    end
    it 'cannot use more than 14 digits for cpnj' do
      codeplay =Company.create(email: 'codeplay@codeplay.com.br', cnpj: 1234567891011111110, 
      billing_address:'Rua Tal, 50, Centro',
      corporate_name: 'codeplay ltda')

      codeplay.valid?
      
      expect(codeplay).to_not be_valid
      expect(codeplay.errors[:cnpj]).to include('não possui o tamanho esperado (14 caracteres)')
    end

    it 'ensure cnpj is unique' do
      codeplay =Company.create(email: 'codeplay@codeplay.com.br', cnpj: 12345678910110, 
      billing_address:'Rua Tal, 50, Centro',
      corporate_name: 'codeplay ltda')
      codeplay2 =Company.create(email: 'codeplay@codeplay.com.br', cnpj: 12345678910110, 
      billing_address:'Rua Tal, 50, Centro',
      corporate_name: 'codeplay ltda')
  
      codeplay.valid?
      codeplay2.valid?
      expect(codeplay).to be_valid
      expect(codeplay2).to_not be_valid
      expect(codeplay2.errors[:cnpj]).to include('já está em uso')
    end

    it 'ensure email is unique' do
      codeplay =Company.create(email: 'codeplay@codeplay.com.br', cnpj: 12345678910110, 
      billing_address:'Rua Tal, 50, Centro',
      corporate_name: 'codeplay ltda')
      codeplay2 =Company.create(email: 'codeplay@codeplay.com.br', cnpj: 12345678910110, 
      billing_address:'Rua Tal, 50, Centro',
      corporate_name: 'codeplay ltda')
  
      codeplay.valid?
      codeplay2.valid?
      expect(codeplay).to be_valid
      expect(codeplay2).to_not be_valid
      expect(codeplay2.errors[:email]).to include('já está em uso')
    end
  end
end
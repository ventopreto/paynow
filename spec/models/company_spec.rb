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
      expect(codeplay.token.size).to eq(28)
      expect(codeplay).to be_valid
    end
    it 'cannot use more than 14 digits for cpnj' do
      codeplay =Company.create(email: 'codeplay@codeplay.com.br', cnpj: 12345678910110201514, 
      billing_address:'Rua Tal, 50, Centro',
      corporate_name: 'codeplay ltda')

      codeplay.valid?
      
      expect(codeplay).to_not be_valid
      expect(codeplay.errors[:cnpj]).to include('não possui o tamanho esperado (14 caracteres)')
    end
  end
end
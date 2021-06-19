require 'rails_helper'

describe EndUser do
  describe 'Validate' do
    it 'attributes cannot be blank' do
    end_user = EndUser.new


    end_user.valid?

    expect(end_user.errors[:cpf]).to include('não pode ficar em branco')
    expect(end_user.errors[:fullname]).to include('não pode ficar em branco')
    expect(end_user).to_not be_valid

    end

    it 'success register a end user' do
      end_user = EndUser.create(cpf:12345678910, fullname:'Mateus Bruno Abreu')
  
      end_user.valid?
  
      expect(end_user.token.size).to eq(20)
      expect(end_user.cpf).to eq(12345678910)
      expect(end_user.fullname).to eq('Mateus Bruno Abreu')
      expect(end_user).to be_valid
    end

    it 'ensure cpf have 11 digits' do
      end_user = EndUser.create(cpf:123, fullname:'Mateus Bruno Abreu')
  
      end_user.valid?
      expect(end_user.errors[:cpf]).to include('não possui o tamanho esperado (11 caracteres)')
      expect(end_user).to_not be_valid
    end

    it 'ensure cpf is unique' do
      end_user1 = EndUser.create!(cpf:12345678910, fullname:'Mateus Bruno Abreu')
      end_user2 = EndUser.create(cpf:12345678910, fullname:'Mateus Bruno Abreu')
  
      end_user1.valid?
      end_user2.valid?
      expect(end_user1).to be_valid
      expect(end_user2).to_not be_valid
      expect(end_user2.errors[:cpf]).to include('já está em uso')
    end
  end
end
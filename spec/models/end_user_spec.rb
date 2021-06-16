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
  
      expect(end_user.token.size).to eq(24)
      expect(end_user.cpf).to eq(12345678910)
      expect(end_user.fullname).to eq('Mateus Bruno Abreu')
      expect(end_user).to be_valid
    end
  end
end
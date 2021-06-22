require 'rails_helper'

describe User do
  describe 'Validates' do
  it 'fail to create user with email from hotmail' do
    user =User.create(email: 'codeplay@hotmail.com', password: 12345678910110) 

    user.valid?
    expect(user.errors[:email]).to include('não é válido')
    end

    it 'fail to create user with email from gmail' do
      user =User.create(email: 'codeplay@gmail.com', password: 12345678910110) 
  
      user.valid?
  
      expect(user.errors[:email]).to include('não é válido')
      end

    it 'fail to create user with email from yahoo' do
      user =User.create(email: 'codeplay@yahoo.com', password: 12345678910110) 
  
      user.valid?
  
      expect(user.errors[:email]).to include('não é válido')
  
      end

      it 'fail to create user with fake paynow email' do
        user =User.create(email: 'codeplay@paynow.com', password: 12345678910110) 
    
        user.valid?
    
        expect(user.errors[:email]).to include('não é válido')
    
      end
      it 'attributes cannot be blank' do
        user = User.new()

        user.valid?

        expect(user.errors[:email]).to include('não pode ficar em branco')
        expect(user.errors[:password]).to include('não pode ficar em branco')
        expect(user).to_not be_valid
    end

    it 'success' do
      user = User.create(email: 'codeplay@codeplay.com.br', password: 12345678910110)


      user.valid?

      expect(user.email).to eq('codeplay@codeplay.com.br')
      expect(user.password).to eq(12345678910110)

      expect(user).to be_valid
    end

    it 'set_employer' do
      user = User.create(email: 'codeplay@codeplay.com.br', password: 12345678910110)
      codeplay =Company.create(email: 'codeplay@codeplay.com.br', cnpj: 12345678910110, 
      billing_address:'Rua Tal, 50, Centro',
      corporate_name: 'codeplay ltda')

      user.valid?

      expect(user.email).to eq('codeplay@codeplay.com.br')
      expect(user.password).to eq(12345678910110)
      expect(user.set_employer).to eq(true)

      expect(user).to be_valid
    end
  end
end
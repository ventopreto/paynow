require 'rails_helper'

describe Admin do
  context 'Validation' do
    it 'fail to create admin without paynow domain' do
      admin1 = Admin.new(email: 'admin@gmail.com', password: '123456')
      admin2 = Admin.new(email: 'admin@yahoo.com', password: '123456')
      admin3 = Admin.new(email: 'admin@hotmail.com', password: '123456')

      admin1.valid?
      admin2.valid?
      admin3.valid?

      expect(admin1.errors[:email]).to include('não é válido')
      expect(admin1).to_not be_valid
      expect(admin2.errors[:email]).to include('não é válido')
      expect(admin2).to_not be_valid
      expect(admin3.errors[:email]).to include('não é válido')
      expect(admin3).to_not be_valid

    end

    it 'success to create with paynow domain' do
      admin = Admin.new(email: 'admin@paynow.com.br', password: '123456')

      admin.valid?

      expect(admin).to be_valid
    end

    it 'attributes cannot be blank' do
      admin = Admin.new

      admin.valid?

      expect(admin.errors[:password]).to include('não pode ficar em branco')
      expect(admin.errors[:email]).to include('não pode ficar em branco')
      expect(admin).to_not be_valid
    end

    it 'create a valid Admin' do
      admin = Admin.new(email: 'admin@paynow.com.br', password: '123456')

      admin.valid?

      expect(admin.email).to eq('admin@paynow.com.br')
      expect(admin.password).to eq('123456')
      expect(admin).to be_valid
    end
  end
end

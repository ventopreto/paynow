require 'rails_helper'

describe Product do
  describe 'Validate' do
    it 'attributes cannot be blank' do
    product = Product.new


    product.valid?

    expect(product.errors[:name]).to include('não pode ficar em branco')
    expect(product.errors[:price]).to include('não pode ficar em branco')
    expect(product).to_not be_valid

    end

    it 'success register a product' do
      codeplay =Company.create(email: 'codeplay@codeplay.com.br', cnpj: 12345678910110, 
      billing_address:'Rua Tal, 50, Centro',
      corporate_name: 'codeplay ltda')
      product = Product.create(name: 'Curso de Rails', price: 720, company:codeplay)


      product.valid?
  

      expect(product.name).to eq('Curso de Rails')
      expect(product.price).to eq(720)
      expect(product).to be_valid
      expect(product.token.size).to eq(28)
    end
  end
end
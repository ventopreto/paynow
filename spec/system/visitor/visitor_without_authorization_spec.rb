describe 'Unauthorized Visitor ' do
  describe 'should not access admin pages' do

    it 'index payment method' do
      visit admin_payment_methods_path

      expect(current_path).to eq(new_admin_session_path)
    end

    it 'show payment method' do
      boleto = PaymentMethod.create(name: 'Boleto', max_fee: 10, percentage_fee:10, category: 1)
      visit admin_payment_method_path(boleto)

      expect(current_path).to eq(new_admin_session_path)
    end

    it 'new payment method' do
      boleto = PaymentMethod.create(name: 'Boleto', max_fee: 10, percentage_fee:10, category: 1)
      visit new_admin_payment_method_path

      expect(current_path).to eq(new_admin_session_path)
    end

    it 'post request to payment method' do
      post admin_payment_methods_path, params: {payment_method: {name: 'Boleto'}}

      expect(response).to redirect_to(new_admin_session_path)
    end

    it 'update payment method' do
      boleto = PaymentMethod.create(name: 'Boleto', max_fee: 10, percentage_fee:10, category: 1)
      visit edit_admin_payment_method_path(boleto)

      expect(current_path).to eq(new_admin_session_path)
    end

    it 'patch request to payment method' do
      boleto = PaymentMethod.create(name: 'Boleto', max_fee: 10, percentage_fee:10, category: 1)
      patch admin_payment_method_path(boleto)

      expect(response).to redirect_to(new_admin_session_path)
    end

    it 'delete request to payment method' do
      boleto = PaymentMethod.create(name: 'Boleto', max_fee: 10, percentage_fee:10, category: 1)
  
      delete admin_payment_method_path(boleto)
      expect(response).to redirect_to(new_admin_session_path)
    end
  end

  describe 'should not access user' do
    it 'new company page' do

      visit new_user_company_path

      expect(current_path).to eq(new_user_session_path)
    end

    it 'post company page' do
      post user_companies_path, params: {company: {email: 'admin@codeplay.com'}}

      expect(response).to redirect_to(new_user_session_path)
    end

    it 'show company page' do
      company = Company.create(email:'admin@codeplay.com.br', billing_address: 'Rua x, 420',
                                                    corporate_name: 'Codeplay', cnpj:12345678910110)

      visit user_company_path(company)
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
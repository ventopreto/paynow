describe 'Unauthorized' do
  describe 'fail' do
    it 'to visit payment_method updates form page' do
      boleto = PaymentMethod.create!(name: 'Boleto', max_fee: 10, percentage_fee:10)
      visit edit_admin_payment_method_path(boleto)

      expect(current_path).to eq(new_admin_session_path)
    end

    it 'to send patch request to payment method' do
      boleto = PaymentMethod.create!(name: 'Boleto', max_fee: 10, percentage_fee:10)
      patch admin_payment_method_path(boleto)

      expect(response).to redirect_to(new_admin_session_path)
    end

    it 'to visit payment method create form page' do
      boleto = PaymentMethod.create!(name: 'Boleto', max_fee: 10, percentage_fee:10)
      visit new_admin_payment_method_path

      expect(current_path).to eq(new_admin_session_path)
    end

    it 'to send post request to payment method' do
      post admin_payment_methods_path, params: {payment_method: {name: 'Boleto'}}

      expect(response).to redirect_to(new_admin_session_path)
    end
    it 'to send delete request to payment method' do
      boleto = PaymentMethod.create(name: 'Boleto', max_fee: 10, percentage_fee:10)
  
      delete admin_payment_method_path(boleto)
      expect(response).to redirect_to(new_admin_session_path)
    end
  end
end
describe 'Unauthorized Visitor ' do
  let(:company) {Company.create!(email:'admin@codeplay.com.br', billing_address: 'Rua x, 420',
  corporate_name: 'Codeplay', cnpj:12345678910110)}
  let(:payment_method_boleto) {PaymentMethod.create!(name: 'Banco Roxinho', max_fee: 10, percentage_fee:10, category: 'Boleto')}
  let(:payment_method_credit_card) {PaymentMethod.create!(name: 'Banco Roxinho', max_fee: 10, percentage_fee:10, category: 'Cartão')}
  let(:payment_method_pix) {PaymentMethod.create!(name: 'Banco Roxinho', max_fee: 10, percentage_fee:10, category: 'Pix')}
  let(:boleto) {Boleto.create!(bank_code: 102, agency_number:1234, bank_account: 123456, payment_method:payment_method_boleto, company: company)}
  let(:pix) {Pix.create!(bank_code: 102, pix_key:12345678909876543210, payment_method:payment_method_pix, company: company)}
  let(:credit_card) {CreditCard.create!(token:12345678909876543210, payment_method:payment_method_credit_card, company: company)}
  describe 'should not access admin pages' do

    it 'index payment method' do
      visit admin_payment_methods_path

      expect(current_path).to eq(new_admin_session_path)
    end

    it 'show payment method' do
      visit admin_payment_method_path(payment_method_boleto)

      expect(current_path).to eq(new_admin_session_path)
    end

    it 'new payment method' do
      visit new_admin_payment_method_path

      expect(current_path).to eq(new_admin_session_path)
    end

    it 'post request to payment method' do
      post admin_payment_methods_path, params: {payment_method: {name: 'Boleto'}}

      expect(response).to redirect_to(new_admin_session_path)
    end

    it 'update payment method' do

      visit edit_admin_payment_method_path(payment_method_boleto)

      expect(current_path).to eq(new_admin_session_path)
    end

    it 'patch request to payment method' do
      patch admin_payment_method_path(payment_method_boleto)

      expect(response).to redirect_to(new_admin_session_path)
    end

    it 'delete request to payment method' do
  
      delete admin_payment_method_path(payment_method_boleto)
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


      visit user_company_path(company)
      expect(current_path).to eq(new_user_session_path)
    end

    it 'index company chosen_payments page' do

      visit user_company_chosen_payments_path(company)
      expect(current_path).to eq(new_user_session_path)
    end

    it 'new boleto page' do

      visit new_user_payment_method_boleto_path(payment_method_boleto)

      expect(current_path).to eq(new_user_session_path)
    end

      it 'post request to boleto' do

        post user_payment_method_boletos_path(payment_method_boleto), params: {boleto: {bank_code: '102'}}

        expect(response).to redirect_to(new_user_session_path)
    end

    it 'update boleto' do

      visit edit_user_payment_method_boleto_path(payment_method_boleto, boleto)

      expect(current_path).to eq(new_user_session_path)
  end

    it 'patch request to boleto' do

      patch user_payment_method_boleto_path(payment_method_boleto, boleto)

      expect(response).to redirect_to(new_user_session_path)
    end


    it 'new credit card page' do

      visit new_user_payment_method_credit_card_path(payment_method_credit_card)

      expect(current_path).to eq(new_user_session_path)
    end

      it 'post request to credit card' do

        post user_payment_method_credit_cards_path(payment_method_credit_card), params: {credit_card: {token: '12345678909876543210'}}

        expect(response).to redirect_to(new_user_session_path)
    end

    it 'update credit card' do

      visit edit_user_payment_method_credit_card_path(payment_method_credit_card, credit_card)

      expect(current_path).to eq(new_user_session_path)
  end


  it 'patch request to credit card' do

    patch user_payment_method_credit_card_path(payment_method_credit_card, credit_card)

    expect(response).to redirect_to(new_user_session_path)
  end

    it 'new pix page' do

      visit new_user_payment_method_pix_path(payment_method_pix)

      expect(current_path).to eq(new_user_session_path)
    end

      it 'post request to pix' do

        post user_payment_method_pixes_path(payment_method_pix), params: {credit_card: {bank_code: '12345678909876543210'}}

        expect(response).to redirect_to(new_user_session_path)
    end

      it 'update pix' do

        visit edit_user_payment_method_pix_path(payment_method_pix, pix)

        expect(current_path).to eq(new_user_session_path)

        
    end

    it 'patch request to pix' do

      patch user_payment_method_pix_path(payment_method_pix, pix)
  
      expect(response).to redirect_to(new_user_session_path)

    end
  end
end
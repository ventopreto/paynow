require 'rails_helper'

describe 'User' do
  describe 'visit' do
  it 'registration page successfully' do
    visit root_path
    click_on 'Cadastre-se'

    expect(current_path).to eq(new_user_registration_path)
    end
  end
end
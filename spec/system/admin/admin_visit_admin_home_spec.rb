require 'rails_helper'

describe 'Admin visit home' do
  it 'successfully' do
    admin = Admin.create!(email: 'admin@paynow.com.br', password: '123456')

    login_as admin, scope: :admin
    visit admin_root_path

    expect(current_path).to eq(admin_root_path)
  end

  it 'and fail' do
    admin = Admin.create!(email: 'admin@paynow.com.br', password: '123456')

    visit admin_root_path

    expect(current_path).to eq(new_admin_session_path)
  end
end
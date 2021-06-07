module LoginMacros
  def admin_login( admin = Admin.create!(email: 'admin@gmail.com', password: '123456'))
    login_as admin, scope: :admin
  end
end
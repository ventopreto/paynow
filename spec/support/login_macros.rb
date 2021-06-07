module LoginMacros
  def admin_login( admin = Admin.new(email: 'admin@gmail.com', password: '123456'))
    login_as admin
  end
end
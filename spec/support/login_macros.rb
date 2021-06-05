module LoginMacros
  def user_login( user = User.create!(email: 'x@gmail.com', password: '123456'))
    login_as user, scope: :user
  end

  def student_login( student = Student.create!(email: 'g@gmail.com', password: '123456'))
    login_as student, scope: :student
  end
end
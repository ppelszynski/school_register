module TeacherMailerHelper
  def encrypt_email(email)
    token = SymmetricEncryption.encrypt email
    token.sub!('/', '{}')
    token
  end
end
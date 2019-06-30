module TeacherMailerHelper
  def encrypt_email(email)
    token = "\"#{SymmetricEncryption.encrypt email}\""
  end
end

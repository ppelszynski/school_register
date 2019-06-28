module TeacherMailerHelper
  def encrypt_email(email)
    enc = Base64.encode64(email)
    enc
  end
end

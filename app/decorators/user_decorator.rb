class UserDecorator < Draper::Decorator
  delegate_all

  def encrypted_email
    token = SymmetricEncryption.encrypt object.email
    token.sub('/', '{}')
  end
end

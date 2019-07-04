require 'symmetric_encryption'

class DecryptEmail < Patterns::Service
  def initialize(token)
    @token = token
  end

  def call
    email = decrypt(token)
    email
  end

  private

  attr_reader :token

  def decrypt(token)
    SymmetricEncryption.decrypt token.sub('{}', '/')
  end
end

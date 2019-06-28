class DecryptEmail < Patterns::Service
  def initialize(token)
    @token = token
  end

  def call
    email = decrypt(token)
    email
  end

  private

  def decrypt(token)
    plain = Base64.decode64(token)
    plain
  end

  attr_reader :token
end

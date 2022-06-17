# UserService::PasswordValidator.new(user, raw_password).valid?
module UserService
  class PasswordValidator
    attr_reader :user, :raw_password

    def initialize(user, raw_password)
      @user, @raw_password = user, raw_password
    end

    def valid?
      user.valid_password?(raw_password)
    end
  end
end

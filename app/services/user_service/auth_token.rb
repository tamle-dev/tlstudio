# UserService::AuthToken.issue
module UserService
  class AuthToken
    ALGORITHM = 'HS256'.freeze
    ISS       = 'https://remitano.com'.freeze

    def self.issue(user, options = {})
      iat = (options[:iat] || Time.zone.now).to_i
      exp = (options[:exp] || Time.zone.now.to_i + ENV['JWT_TTL'].to_i).to_i

      payload = {
        sub: user.id,
        iss: ISS,
        iat: iat,
        nbf: iat,
        exp: exp
      }

      JWT.encode payload, private_key, ALGORITHM
    end

    def self.decode(token, verify_iss: true, verify: true)
      options = {
        algorithm:  ALGORITHM,
        iss:        ISS,
        verify_iss: true
      }

      JWT.decode(token, private_key, verify, options).first
    end

    def self.private_key
      ENV["JWT_SECRET"]
    end
  end
end

RSpec.shared_context 'api_auth_preparing' do |options = {}|
  let(:current_user)    { User.new username:'tamle1', password: 'secret', id: 1 }
  let(:current_user_id) { current_user.id }
  let(:auth_token_iat)  { nil }
  let(:auth_token_exp)  { nil }
  let(:auth_token)      { UserService::AuthToken.issue current_user, iat: auth_token_iat, exp: auth_token_exp }
  let(:headers) do
    {
      'HTTP_AUTHORIZATION' => auth_token
    }
  end
end

RSpec.shared_context 'api_auth' do |options = {}|
  include_context 'api_auth_preparing'

  before do
    current_user.save
  end

  context 'when unauthorized error' do
    context 'when missing auth_token' do
      let(:headers) { {} }
      it 'responds status 401' do
        action
        expect(response.status).to eq(options[:missing_auth_token_status] || 401)
      end
    end

    context 'when auth_token is blank' do
      let(:auth_token) { '' }
      it 'responds status 401' do
        action
        expect(response.status).to eq(options[:missing_auth_token_status] || 401)
      end
    end

    context 'when invalid auth_token' do
      let(:auth_token) { 'invalid_auth_token' }
      it 'responds status 401' do
        action
        expect(response.status).to eq 401
      end
    end

    context 'when auth_token expired' do
      let(:auth_token_exp) { 1.days.ago }
      it 'responds status 401' do
        action
        expect(response.status).to eq 401
      end
    end

    context 'when auth_token_issued_at is 1.days.from_now' do
      let(:auth_token_iat) { 1.days.from_now }
      it 'responds status 401' do
        action
        expect(response.status).to eq 401
      end
    end
  end
end

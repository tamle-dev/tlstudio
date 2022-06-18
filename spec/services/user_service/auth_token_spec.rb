require 'rails_helper'

describe UserService::AuthToken do
  subject { described_class }

  describe '.decode' do
    let(:token) { 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHBzOi8vbmltYmxlaHEuY29tIiwiaWF0IjoxNjI4Njk3ODg0LCJuYmYiOjE2Mjg2OTc4ODQsImV4cCI6MTYyODc4NDI4NH0.IslstUxd63A6ae1i_Q-nalTIpfuONX-5l7jayt3sdpM' }

    it 'returns a payload' do
      expect(subject.decode(token, verify: false)).to eq({'exp'=>1628784284, 'iat'=>1628697884, 'iss'=>'https://nimblehq.com', 'nbf'=>1628697884, 'sub'=>1})
    end

    context 'when token expired' do
      it 'raises exception' do
        expect{subject.decode(token, verify: true)}.to raise_error JWT::VerificationError
      end
    end
  end
end

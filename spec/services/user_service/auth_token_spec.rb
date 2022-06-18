require 'rails_helper'

describe UserService::AuthToken do
  subject { described_class }

  let(:token) { 'eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOjEsImNvZCI6ImciLCJmZWEiOjAsImlzcyI6Imh0dHBzOi8vZHV0eWNhc3QuY29tIiwiaWF0IjoxNTYzNzcyMzMyLCJuYmYiOjE1NjM3NzIzMzIsImV4cCI6MTU2Mzg1ODczMiwiYXVkIjpbXSwianRpIjoiNjI0YmQ0YmMxN2JmN2FiNDY2ZTQ5OTFlNzIxOTdmZGQifQ.NdHD0kAHqmBHzDYZ5wFcI_xz5s9WQWDrnQPOF8wfEWXau0Tlb_Y2l1McnS9j2W-tCWuBlz7OZr5Lb2PM41h6AZQK9kAGtb2PjUSnRMThFYWm1lRUSDnsTTxNNbkNMl3PLieswRez2-JubBJWeYzTxYuYpSQBkJUDk5ufsh24QNGQYY9XklvnXivY6pJ93-HnYn8i7cotPhPxKPGOo2C0Bg4iI8IeR6ixIC-bGv_l248-EWED6kuMmJ_EzxKRGliMvrqxM7-L3pxooOvjUlnP-djM7wA7NGFreM_7E8y7UZ8zBIRc7j6dXejYxL7CI04RD-EU9e88HVZ0G4Sf6lYlaQ' }
  let(:auth_token_expires_at) { Time.new(2019, 7, 23, 12, 12 , 12, '+07:00') }
  describe '.issue' do
    let(:auth_token_issued_at) { Time.new(2019, 7, 22, 12, 12 , 12, '+07:00') }
    let(:user) { User.new id: 1, auth_token_issued_at: auth_token_issued_at, auth_token_expires_at: auth_token_expires_at }

    it 'returns right jwt token' do
      expect(subject.issue(user)).to eq token
    end
  end

  describe '.decode' do
    it 'returns a payload' do
      expect(subject.decode(token, verify: false)).to eq({"aud"=>[], "cod"=>"g", "exp"=>1563858732, "fea"=>0, "iat"=>1563772332, "iss"=>"https://dutycast.com", "jti"=>"624bd4bc17bf7ab466e4991e72197fdd", "nbf"=>1563772332, "sub"=>1})
    end

    context 'when has leeway' do
      let(:exp_leeway) { Time.zone.now - auth_token_expires_at + 1 }
      it 'returns a payload' do
        expect(subject.decode(token, verify: true, exp_leeway: exp_leeway)).to be_a Hash
      end
    end
  end
end

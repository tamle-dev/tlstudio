require 'rails_helper'

describe UserService::PasswordValidator do
  let(:user) { User.new password: 'secret1' }
  let(:raw_password) { 'secret1' }
  subject { described_class.new(user, raw_password) }

  describe '#valid?' do
    it 'returns true' do
      expect(subject.valid?).to be true
    end

    context 'when invalid raw_password' do
      let(:raw_password) { 'secret2' }
      it 'returns false' do
        expect(subject.valid?).to be false
      end
    end
  end
end

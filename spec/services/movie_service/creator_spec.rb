require 'rails_helper'

describe MovieService::Creator do
  include_context 'youtube_stub', code: 'TSzcs3Ej90c'

  let(:user) { User.create }
  let(:params) do
    {
      url: 'https://www.youtube.com/watch?v=TSzcs3Ej90c&ab_channel=DuyThanhNguyen'
    }
  end

  subject { described_class.new(user, params) }

  describe '#exec' do
    it 'returns a Movie' do
      result = subject.exec
      expect(result).to be_a Movie
      expect(result.id).not_to be_blank
      expect(result.url).to eq 'https://www.youtube.com/watch?v=TSzcs3Ej90c'
      expect(result.external_like).to eq 35566425
      expect(result.external_comment).to eq nil
      expect(result.external_view).to eq 10809215506
      expect(result.external_code).to eq 'TSzcs3Ej90c'
      expect(result.title).not_to be_blank
      expect(result.description).not_to be_blank
      expect(result.author).not_to be_blank
    end

    it 'increases Movie count' do
      expect{subject.exec}.to change{Movie.count}.by(1)
    end
  end
end

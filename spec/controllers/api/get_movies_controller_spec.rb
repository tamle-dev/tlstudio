require 'rails_helper'

describe Api::GetMoviesController, type: :request do
  describe 'get /api/movies/share' do
    let(:params) { {} }
    let(:headers) { {} }
    let(:action) { get '/api/movies', params: params, headers: headers }

    before do
      Movie.create url: 'https://www.youtube.com/watch?v=TSzcs3Ej90c', external_like: 1000, external_comment: 2000, external_view: 5000, external_code: 'TSzcs3Ej90c', title: 'Lạm Phát và Đầu Tư Chứng Khoán: Giải Thích Đơn Giản', description: 'Tiếp theo video trước mình đã giải thích Lạm Phát là gì', author: 'Duy Thanh Nguyen'
    end

    context 'when success' do
      it 'responds status 201' do
        action
        expect(response.status).to eq 200

        json = JSON.parse response.body
        expect(json).to have_key 'data'
        expect(json['data'][0]).to have_key 'id'
        expect(json['data'][0]).to have_key 'url'
        expect(json['data'][0]).to have_key 'external_like'
        expect(json['data'][0]).to have_key 'external_comment'
        expect(json['data'][0]).to have_key 'external_view'
        expect(json['data'][0]).to have_key 'external_code'
        expect(json['data'][0]).to have_key 'title'
        expect(json['data'][0]).to have_key 'description'
        expect(json['data'][0]).to have_key 'author'
      end
    end
  end
end

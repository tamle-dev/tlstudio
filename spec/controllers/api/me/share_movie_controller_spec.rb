require 'rails_helper'

describe Api::Me::ShareMovieController, type: :request do
  describe 'post /api/me/movies/share' do
    include_context 'api_auth'

    let(:url) { 'https://www.youtube.com/watch?v=fAOHvnP3J7I&ab_channel=DuyThanhNguyen' }
    let(:params) do 
      { 
        url: url
      }
    end
    let(:action) { post '/api/me/movies/share', params: params, headers: headers }

    context 'when success' do
      it 'responds status 201' do
        action
        expect(response.status).to eq 201

        json = JSON.parse response.body
        expect(json).to have_key 'data'
        expect(json['data']).to have_key 'id'
        expect(json['data']).to have_key 'url'
        expect(json['data']).to have_key 'external_like'
        expect(json['data']).to have_key 'external_comment'
        expect(json['data']).to have_key 'external_view'
        expect(json['data']).to have_key 'external_code'
        expect(json['data']).to have_key 'title'
        expect(json['data']).to have_key 'description'
        expect(json['data']).to have_key 'author'
      end
    end

    context 'when error' do
      context 'when invalid url' do
        let(:url) { 'https://google.com' }

        it 'responds status 400' do
          action
          expect(response.status).to eq 400
        end
      end
    end
  end
end

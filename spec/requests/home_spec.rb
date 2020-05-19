# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'home', type: :request do
  describe 'adminユーザ操作' do
    before do
      create(:adm_user)
      post '/login', params: { session: { name: 'kyokai', password: 'kyokaipw' } }
    end

    context 'トップ画面' do
      it 'GET /' do
        get '/'
        expect(response).to have_http_status(:ok)
        expect(response.body).to include 'ユーザ管理'
        expect(response.body).to include 'ログアウト'
      end
    end
  end

  describe 'normalユーザ操作' do
    before do
      create(:normal_user)
      post '/login', params: { session: { name: 'ohon', password: 'ohonpw' } }
    end

    context 'トップ画面' do
      it 'GET /' do
        get '/'
        expect(response).to have_http_status(:ok)
        expect(response.body).not_to include 'ユーザ管理'
        expect(response.body).to include 'ログアウト'
      end
    end
  end
end

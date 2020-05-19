# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'home', type: :request do
  describe 'adminユーザ操作' do
    let!(:login_user) { create(:adm_user) }

    before do
      post '/login', params: { session: { name: 'kyokai', password: 'kyokaipw' } }
    end

    context 'トップ画面' do
      it 'GET /' do
        get '/'
        expect(response).to have_http_status(200)
        expect(response.body).to include 'ユーザ管理'
        expect(response.body).to include 'ログアウト'
      end
    end
  end

  describe 'normalユーザ操作' do
    let!(:login_user) { create(:normal_user) }

    before do
      post '/login', params: { session: { name: 'ohon', password: 'ohonpw' } }
    end

    context 'トップ画面' do
      it 'GET /' do
        get '/'
        expect(response).to have_http_status(200)
        expect(response.body).not_to include 'ユーザ管理'
        expect(response.body).to include 'ログアウト'
      end
    end
  end
end

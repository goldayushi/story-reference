# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  include SessionsHelper

  describe 'ユーザ新規登録' do
    context 'GET /users/new' do
      it 'render new' do
        get '/users/new'
        expect(response).to have_http_status(:ok)
      end
    end

    context 'POST /users' do
      it 'success create user' do
        expect do
          post '/users', params: { user: { name: 'ohon', password: 'ohonpw' } }
        end.to change(User, :count).by(1)
        expect(response).to redirect_to login_path
      end

      it 'failed create user(not name)' do
        post '/users', params: { user: { name: '', password: 'ohonpw' } }
        expect(response.body).to include 'ユーザ名を入力してください'
      end

      it 'failed create user(not password)' do
        post '/users', params: { user: { name: 'ohon', password: '' } }
        expect(response.body).to include 'パスワードを入力してください'
      end

      let!(:user) { create(:normal_user_2) }

      it "failed create user(exit name)" do
        post '/users', params: { user: { name: 'moten', password: 'ohonpw' } }
        expect(response.body).to include 'ユーザ名はすでに存在します'
      end
    end
  end

  describe 'ユーザ管理(管理権限あり)' do
    let!(:edit_user) { create(:normal_user) }

    before do
      create(:adm_user)
      post '/login', params: { session: { name: 'kyokai', password: 'kyokaipw' } }
    end

    context 'ユーザ一覧画面' do
      it 'GET /users' do
        get '/users'
        expect(response).to have_http_status(:ok)
      end
    end

    context 'ユーザ編集' do
      it 'GET /users/:id/edit' do
        get '/users/' + edit_user.id.to_s + '/edit'
        expect(response).to have_http_status(:ok)
      end

      it 'PUT /users/:id　success' do
        expect do
          put '/users/' + edit_user.id.to_s, params: { user: { admin: true } }
        end.to change(User, :count).by(0)
        expect(response).to redirect_to users_path
      end
    end

    context 'ユーザ削除' do
      it 'DELETE /users/:id' do
        expect do
          delete '/users/' + edit_user.id.to_s
        end.to change(User, :count).by(-1)
        expect(response).to redirect_to users_path
      end
    end
  end

  describe 'ユーザ管理(管理権限なし)' do
    let!(:edit_user) { create(:normal_user_2) }

    before do
      create(:normal_user)
      post '/login', params: { session: { name: 'ohon', password: 'ohonpw' } }
    end

    context 'ユーザ一覧画面' do
      it 'GET /users' do
        get '/users'
        expect(response).to redirect_to root_path
      end
    end

    context 'ユーザ編集' do
      it 'GET /users/:id/edit' do
        get '/users/' + edit_user.id.to_s + '/edit'
        expect(response).to redirect_to root_path
      end

      it 'PUT /users/:id' do
        put '/users/' + edit_user.id.to_s, params: { user: { admin: true } }
        expect(response).to redirect_to root_path
      end
    end

    context 'ユーザ削除' do
      it 'DELETE /users/:id' do
        delete '/users/' + edit_user.id.to_s
        expect(response).to redirect_to root_path
      end
    end
  end
end

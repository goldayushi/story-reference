require 'rails_helper'

RSpec.describe "Users", type: :request do
  include SessionsHelper

  describe "ユーザ新規登録" do

    context "GET /users/new" do
      it "render new" do
        get '/users/new'
        expect(response).to have_http_status(200)
      end
    end

    context 'POST /users' do
      it "success create user" do
        expect do
          post '/users', params: { user: { name: 'ohon', password: 'ohonpw' } }
        end.to change(User, :count).by(1)
        expect(response).to redirect_to login_path
      end

      it "failed create user(not name)" do
        post '/users', params: { user: { name: '', password: 'ohonpw' } }
        expect(response.body).to include 'ユーザ名を入力してください'
      end

      it "failed create user(not password)" do
        post '/users', params: { user: { name: 'ohon', password: '' } }
        expect(response.body).to include 'パスワードを入力してください'
      end
    end
  end

  describe "ユーザ管理" do
    let!(:login_user) { FactoryBot.create(:adm_user) }
    let!(:edit_user) { FactoryBot.create(:normal_user) }

    before do
      post '/login', params: { session: { name: 'kyokai', password: 'kyokaipw' } }
    end

    context "GET /users/:id/edit" do
      it "get edit" do
        get '/users/' + edit_user.id.to_s + '/edit'
        expect(response).to have_http_status(200)
      end
    end

    context "PUT /users/delete/:id" do
      it "success update user" do
        expect do
          put '/users/' + edit_user.id.to_s, params: { user: { admin: true } }
        end.to change(User, :count).by(0)
        expect(response).to redirect_to users_path
      end
    end

    context "DELETE /users/delete/:id" do
      it "success delete user" do
        expect do
          delete '/users/' + edit_user.id.to_s
        end.to change(User, :count).by(-1)
        expect(response).to redirect_to users_path
      end
    end
  end
end
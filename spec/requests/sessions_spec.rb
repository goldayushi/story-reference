require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  include SessionsHelper

  let!(:user) { FactoryBot.create(:adm_user) }

  describe "GET /login" do
    it "render new" do
      get '/login'
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /login' do
    it "success create sessions" do
      post '/login', params: { session: { name: 'kyokai', password: 'kyokaipw' } }
      expect(response).to redirect_to root_path
    end

    it "failed create sessions(not name)" do
      post '/login', params: { session: { name: 'ohon', password: 'shinpw' } }
      expect(response.body).to include 'ユーザ名かパスワードが正しくありません'
    end

    it "failed create sessions(not password)" do
      post '/login', params: { session: { name: 'kyokai', password: 'ohonpw' } }
      expect(response.body).to include 'ユーザ名かパスワードが正しくありません'
    end
  end

  describe "DELETE /logout" do
    before do
      post '/login', params: { session: { name: 'kyokai', password: 'kyokaipw' } }
    end

    it "success delete sessions" do
      log_in(user)
      delete '/logout'
      expect(response).to redirect_to login_path
    end
  end
end
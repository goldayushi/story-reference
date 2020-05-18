require 'rails_helper'

RSpec.describe "episodes", type: :request do

  let!(:edit_episode) { create(:episode) }

  describe "adminユーザ操作" do
    let!(:login_user) { create(:adm_user) }

    before do
      post '/login', params: { session: { name: 'kyokai', password: 'kyokaipw' } }
    end

    context "エピソード一覧画面" do
      it "GET /episodes" do
        get '/episodes'
        expect(response).to have_http_status(200)
        expect(response.body).to include 'episodes/new'
        expect(response.body).to include '編集'
        expect(response.body).to include '削除'
      end
    end

    context "エピソード詳細画面" do
      it "GET /episodes/:id" do
        get '/episodes/' + edit_episode.id.to_s
        expect(response).to have_http_status(200)
        expect(response.body).to include '編集'
        expect(response.body).to include '削除'
      end
    end

    context "エピソード登録" do
      it "GET /episodes/new" do
        get '/episodes/new'
        expect(response).to have_http_status(200)
      end

      it "POST /episodes success" do
        expect do
          post '/episodes', params: { episode: { chapter: 1, 
                                                  title: 'title_test',
                                                  overview: 'overview',
                                                  content: 'content',
                                                  set: 'set',
                                                  keyitem: 'keyitem',
                                                  division: 'division',
                                                  year: 1 } }
        end.to change(Episode, :count).by(1)
        expect(response).to redirect_to episodes_path
      end

      it "POST /episodes failed(not name)" do
        expect do
          post '/episodes', params: { episode: { chapter: 1, 
                                                  title: '',
                                                  overview: 'overview',
                                                  content: 'content',
                                                  set: 'set',
                                                  keyitem: 'keyitem',
                                                  division: 'division',
                                                  year: 1 } }
        end.to change(Episode, :count).by(0)
        expect(response.body).to include 'タイトルを入力してください'
      end
    end

    context "エピソード編集" do
      it "GET /episodes/:id/edit" do
        get '/episodes/' + edit_episode.id.to_s + '/edit'
        expect(response).to have_http_status(200)
      end

      it "PUT /episodes/:id　success" do
        expect do
          put '/episodes/' + edit_episode.id.to_s, params: { episode: { title: 'change_name' } }
        end.to change(Episode, :count).by(0)
        expect(response).to redirect_to "/episodes/#{edit_episode.id}"
      end

      it "PUT /episodes/:id failed" do
        expect do
          put '/episodes/' + edit_episode.id.to_s, params: { episode: { title: '' } }
        end.to change(Episode, :count).by(0)
        expect(response.body).to include 'タイトルを入力してください'
      end
    end

    context "エピソード削除" do
      it "DELETE /episodes/:id" do
        expect do
          delete '/episodes/' + edit_episode.id.to_s
        end.to change(Episode, :count).by(-1)
        expect(response).to redirect_to episodes_path
      end
    end
  end

  describe "normalユーザ操作" do
    let!(:login_user) { create(:normal_user) }

    before do
      post '/login', params: { session: { name: 'ohon', password: 'ohonpw' } }
    end

    context "エピソード一覧画面" do
      it "GET /episodes" do
        get '/episodes'
        expect(response).to have_http_status(200)
        expect(response.body).not_to include 'episodes/new'
        expect(response.body).not_to include '編集'
        expect(response.body).not_to include '削除'
      end
    end

    context "エピソード詳細画面" do
      it "GET /episodes/:id" do
        get '/episodes/' + edit_episode.id.to_s
        expect(response).to have_http_status(200)
        expect(response.body).not_to include '編集'
        expect(response.body).not_to include '削除'
      end
    end

    context "エピソード登録" do
      it "GET /episodes/new" do
        get '/episodes/new'
        expect(response).to redirect_to root_path
      end

      it "POST /episodes/:id" do
        expect do
          put '/episodes/' + edit_episode.id.to_s, params: { episode: { name: 'change_name' } }
        end.to change(Episode, :count).by(0)
        expect(response).to redirect_to root_path
      end
    end

    context "エピソード編集" do
      it "GET /episodes/:id/edit" do
        get '/episodes/' + edit_episode.id.to_s + '/edit'
        expect(response).to redirect_to root_path
      end

      it "PUT /episodes/:id" do
        expect do
          put '/episodes/' + edit_episode.id.to_s, params: { episode: { name: 'change_name' } }
        end.to change(Episode, :count).by(0)
        expect(response).to redirect_to root_path
      end
    end

    context "エピソード削除" do
      it "DELETE /episodes/:id" do
        expect do
          delete '/episodes/' + edit_episode.id.to_s
        end.to change(Episode, :count).by(0)
        expect(response).to redirect_to root_path
      end
    end
  end
end
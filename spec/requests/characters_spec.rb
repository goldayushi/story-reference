require 'rails_helper'

RSpec.describe "Characters", type: :request do

  let!(:edit_character) { create(:character) }

  describe "adminユーザ操作" do
    let!(:login_user) { create(:adm_user) }

    before do
      post '/login', params: { session: { name: 'kyokai', password: 'kyokaipw' } }
    end

    context "登場人物一覧画面" do
      it "GET /characters" do
        get '/characters'
        expect(response).to have_http_status(200)
        expect(response.body).to include 'characters/new'
        expect(response.body).to include '編集'
        expect(response.body).to include '削除'
      end
    end

    context "登場人物詳細画面" do
      it "GET /characters/:id" do
        get '/characters/' + edit_character.id.to_s
        expect(response).to have_http_status(200)
        expect(response.body).to include '編集'
        expect(response.body).to include '削除'
      end
    end

    context "登場人物登録" do
      it "GET /characters/new" do
        get '/characters/new'
        expect(response).to have_http_status(200)
      end

      it "POST /characters success" do
        expect do
          post '/characters', params: { character: { name: 'ohon', 
                                                    role: 'role',
                                                    position: 'position',
                                                    countory: 'countory',
                                                    birthplace: 'birthplace',
                                                    career: 'career',
                                                    person: 'person',
                                                    appearance_chapter: 1 } }
        end.to change(Character, :count).by(1)
        expect(response).to redirect_to characters_path
      end

      it "POST /characters failed(not name)" do
        expect do
          post '/characters', params: { character: { name: '', 
                                                  role: 'role',
                                                  position: 'position',
                                                  countory: 'countory',
                                                  birthplace: 'birthplace',
                                                  career: 'career',
                                                  person: 'person',
                                                  appearance_chapter: 1 } }
        end.to change(Character, :count).by(0)
        expect(response.body).to include '名前を入力してください'
      end
    end

    context "登場人物編集" do
      it "GET /characters/:id/edit" do
        get '/characters/' + edit_character.id.to_s + '/edit'
        expect(response).to have_http_status(200)
      end

      it "PUT /characters/:id　success" do
        expect do
          put '/characters/' + edit_character.id.to_s, params: { character: { name: 'change_name' } }
        end.to change(Character, :count).by(0)
        expect(response).to redirect_to "/characters/#{edit_character.id}"
      end

      it "PUT /characters/:id failed" do
        expect do
          put '/characters/' + edit_character.id.to_s, params: { character: { name: '' } }
        end.to change(Character, :count).by(0)
        expect(response.body).to include '名前を入力してください'
      end
    end

    context "登場人物削除" do
      it "DELETE /characters/:id" do
        expect do
          delete '/characters/' + edit_character.id.to_s
        end.to change(Character, :count).by(-1)
        expect(response).to redirect_to characters_path
      end
    end
  end

  describe "normalユーザ操作" do
    let!(:login_user) { create(:normal_user) }

    before do
      post '/login', params: { session: { name: 'ohon', password: 'ohonpw' } }
    end

    context "登場人物一覧画面" do
      it "GET /characters" do
        get '/characters'
        expect(response).to have_http_status(200)
        expect(response.body).not_to include 'characters/new'
        expect(response.body).not_to include '編集'
        expect(response.body).not_to include '削除'
      end
    end

    context "登場人物詳細画面" do
      it "GET /characters/:id" do
        get '/characters/' + edit_character.id.to_s
        expect(response).to have_http_status(200)
        expect(response.body).not_to include '編集'
        expect(response.body).not_to include '削除'
      end
    end

    context "登場人物登録" do
      it "GET /characters/new" do
        get '/characters/new'
        expect(response).to redirect_to root_path
      end

      it "POST /characters/:id" do
        expect do
          put '/characters/' + edit_character.id.to_s, params: { character: { name: 'change_name' } }
        end.to change(Character, :count).by(0)
        expect(response).to redirect_to root_path
      end
    end

    context "登場人物編集" do
      it "GET /characters/:id/edit" do
        get '/characters/' + edit_character.id.to_s + '/edit'
        expect(response).to redirect_to root_path
      end

      it "PUT /characters/:id" do
        expect do
          put '/characters/' + edit_character.id.to_s, params: { character: { name: 'change_name' } }
        end.to change(Character, :count).by(0)
        expect(response).to redirect_to root_path
      end
    end

    context "登場人物削除" do
      it "DELETE /characters/:id" do
        expect do
          delete '/characters/' + edit_character.id.to_s
        end.to change(Character, :count).by(0)
        expect(response).to redirect_to root_path
      end
    end
  end
end
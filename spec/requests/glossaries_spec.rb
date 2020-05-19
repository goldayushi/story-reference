# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'glossaries', type: :request do
  let!(:edit_glossary) { create(:glossary) }

  describe 'adminユーザ操作' do
    let!(:login_user) { create(:adm_user) }

    before do
      post '/login', params: { session: { name: 'kyokai', password: 'kyokaipw' } }
    end

    context '用語集一覧画面' do
      it 'GET /glossaries' do
        get '/glossaries'
        expect(response).to have_http_status(:ok)
        expect(response.body).to include 'glossaries/new'
        expect(response.body).to include '編集'
        expect(response.body).to include '削除'
      end
    end

    context '用語集詳細画面' do
      it 'GET /glossaries/:id' do
        get '/glossaries/' + edit_glossary.id.to_s
        expect(response).to have_http_status(:ok)
        expect(response.body).to include '編集'
        expect(response.body).to include '削除'
      end
    end

    context '用語集登録' do
      it 'GET /glossaries/new' do
        get '/glossaries/new'
        expect(response).to have_http_status(:ok)
      end

      it 'POST /glossaries success' do
        expect do
          post '/glossaries', params: { glossary: { title: 'title_test',
                                                    content: 'content',
                                                    chapter: 6 } }
        end.to change(Glossary, :count).by(1)
        expect(response).to redirect_to glossaries_path
      end

      it 'POST /glossaries failed(not name)' do
        expect do
          post '/glossaries', params: { glossary: { title: '',
                                                    content: 'content',
                                                    chapter: 6 } }
        end.to change(Glossary, :count).by(0)
        expect(response.body).to include '用語を入力してください'
      end
    end

    context '用語集編集' do
      it 'GET /glossaries/:id/edit' do
        get '/glossaries/' + edit_glossary.id.to_s + '/edit'
        expect(response).to have_http_status(:ok)
      end

      it 'PUT /glossaries/:id　success' do
        expect do
          put '/glossaries/' + edit_glossary.id.to_s, params: { glossary: { title: 'change_title' } }
        end.to change(Glossary, :count).by(0)
        expect(response).to redirect_to "/glossaries/#{edit_glossary.id}"
      end

      it 'PUT /glossaries/:id failed' do
        expect do
          put '/glossaries/' + edit_glossary.id.to_s, params: { glossary: { title: '' } }
        end.to change(Glossary, :count).by(0)
        expect(response.body).to include '用語を入力してください'
      end
    end

    context '用語集削除' do
      it 'DELETE /glossaries/:id' do
        expect do
          delete '/glossaries/' + edit_glossary.id.to_s
        end.to change(Glossary, :count).by(-1)
        expect(response).to redirect_to glossaries_path
      end
    end
  end

  describe 'normalユーザ操作' do
    let!(:login_user) { create(:normal_user) }

    before do
      post '/login', params: { session: { name: 'ohon', password: 'ohonpw' } }
    end

    context '用語集一覧画面' do
      it 'GET /glossaries' do
        get '/glossaries'
        expect(response).to have_http_status(:ok)
        expect(response.body).not_to include 'glossaries/new'
        expect(response.body).not_to include '編集'
        expect(response.body).not_to include '削除'
      end
    end

    context '用語集詳細画面' do
      it 'GET /glossaries/:id' do
        get '/glossaries/' + edit_glossary.id.to_s
        expect(response).to have_http_status(:ok)
        expect(response.body).not_to include '編集'
        expect(response.body).not_to include '削除'
      end
    end

    context '用語集登録' do
      it 'GET /glossaries/new' do
        get '/glossaries/new'
        expect(response).to redirect_to root_path
      end

      it 'POST /glossaries/:id' do
        expect do
          put '/glossaries/' + edit_glossary.id.to_s, params: { glossary: { title: 'title_test2' } }
        end.to change(Glossary, :count).by(0)
        expect(response).to redirect_to root_path
      end
    end

    context '用語集編集' do
      it 'GET /glossaries/:id/edit' do
        get '/glossaries/' + edit_glossary.id.to_s + '/edit'
        expect(response).to redirect_to root_path
      end

      it 'PUT /glossaries/:id' do
        expect do
          put '/glossaries/' + edit_glossary.id.to_s, params: { glossary: { title: 'change_tite' } }
        end.to change(Glossary, :count).by(0)
        expect(response).to redirect_to root_path
      end
    end

    context '用語集削除' do
      it 'DELETE /glossaries/:id' do
        expect do
          delete '/glossaries/' + edit_glossary.id.to_s
        end.to change(Glossary, :count).by(0)
        expect(response).to redirect_to root_path
      end
    end
  end
end

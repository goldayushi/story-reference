# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'chronologies', type: :request do
  let!(:edit_chronology) { create(:chronology) }

  describe 'adminユーザ操作' do
    before do
      create(:adm_user)
      post '/login', params: { session: { name: 'kyokai', password: 'kyokaipw' } }
    end

    context '年表一覧画面' do
      it 'GET /chronologies' do
        get '/chronologies'
        expect(response).to have_http_status(:ok)
        expect(response.body).to include 'chronologies/new'
        expect(response.body).to include '編集'
        expect(response.body).to include '削除'
      end
    end

    context '年表詳細画面' do
      it 'GET /chronologies/:id' do
        get '/chronologies/' + edit_chronology.id.to_s
        expect(response).to redirect_to chronologies_path
      end
    end

    context '年表登録' do
      it 'GET /chronologies/new' do
        get '/chronologies/new'
        expect(response).to have_http_status(:ok)
      end

      it 'POST /chronologies success' do
        expect do
          post '/chronologies', params: { chronology: { year: 501,
                                                        japan_event: 'japan_event',
                                                        korea_event: 'korea_event',
                                                        china_event: 'china_event',
                                                        other_event: 'other_event' } }
        end.to change(Chronology, :count).by(1)
        expect(response).to redirect_to chronologies_path
      end

      it 'POST /chronologies failed(not year)' do
        expect do
          post '/chronologies', params: { chronology: { year: nil,
                                                        japan_event: 'japan_event',
                                                        korea_event: 'korea_event',
                                                        china_event: 'china_event',
                                                        other_event: 'other_event' } }
        end.to change(Chronology, :count).by(0)
        expect(response.body).to include '西暦を入力してください'
      end
    end

    context '年表編集' do
      it 'GET /chronologies/:id/edit' do
        get '/chronologies/' + edit_chronology.id.to_s + '/edit'
        expect(response).to have_http_status(:ok)
      end

      it 'PUT /chronologies/:id　success' do
        expect do
          put '/chronologies/' + edit_chronology.id.to_s, params: { chronology: { year: 502 } }
        end.to change(Chronology, :count).by(0)
        expect(response).to redirect_to chronologies_path
      end

      it 'PUT /chronologies/:id failed' do
        expect do
          put '/chronologies/' + edit_chronology.id.to_s, params: { chronology: { year: nil } }
        end.to change(Chronology, :count).by(0)
        expect(response.body).to include '西暦を入力してください'
      end
    end

    context '年表削除' do
      it 'DELETE /chronologies/:id' do
        expect do
          delete '/chronologies/' + edit_chronology.id.to_s
        end.to change(Chronology, :count).by(-1)
        expect(response).to redirect_to chronologies_path
      end
    end
  end

  describe 'normalユーザ操作' do
    before do
      create(:normal_user)
      post '/login', params: { session: { name: 'ohon', password: 'ohonpw' } }
    end

    context '年表一覧画面' do
      it 'GET /chronologies' do
        get '/chronologies'
        expect(response).to have_http_status(:ok)
        expect(response.body).not_to include 'chronologies/new'
        expect(response.body).not_to include '編集'
        expect(response.body).not_to include '削除'
      end
    end

    context '年表詳細画面' do
      it 'GET /chronologies/:id' do
        get '/chronologies/' + edit_chronology.id.to_s
        expect(response).to redirect_to chronologies_path
      end
    end

    context '年表登録' do
      it 'GET /chronologies/new' do
        get '/chronologies/new'
        expect(response).to redirect_to root_path
      end

      it 'POST /chronologies/:id' do
        expect do
          put '/chronologies/' + edit_chronology.id.to_s, params: { chronology: { year: 503 } }
        end.to change(Chronology, :count).by(0)
        expect(response).to redirect_to root_path
      end
    end

    context '年表編集' do
      it 'GET /chronologies/:id/edit' do
        get '/chronologies/' + edit_chronology.id.to_s + '/edit'
        expect(response).to redirect_to root_path
      end

      it 'PUT /chronologies/:id' do
        expect do
          put '/chronologies/' + edit_chronology.id.to_s, params: { chronology: { year: nil } }
        end.to change(Chronology, :count).by(0)
        expect(response).to redirect_to root_path
      end
    end

    context '年表削除' do
      it 'DELETE /chronologies/:id' do
        expect do
          delete '/chronologies/' + edit_chronology.id.to_s
        end.to change(Chronology, :count).by(0)
        expect(response).to redirect_to root_path
      end
    end
  end
end

require 'rails_helper'

RSpec.describe "Publics::Routes", type: :request do
  let(:user) { create(:user) }
  let(:route) { create(:route) }
  let(:route_params) {{ route: { title: 'テスト用タイトル', explanation: 'テスト用の説明文', user_id: user.id}}}
  let(:invalid_route_params) {{ route: { title: '', explanation: 'テスト用の説明文', user_id: user.id}}}

  describe 'ルート一覧(index)ページのテスト' do
    describe 'ログインしている時' do
      before{ sign_in user }
      context 'ルート一覧ページの表示' do
        it '成功する' do
          get routes_path
          expect(response).to have_http_status(:success)
        end
      end
    end
    describe '未ログインの時でも' do
      context 'ルート一覧ページの表示' do
        it '成功する' do
          get routes_path
          expect(response).to have_http_status(:success)
        end
      end
    end
  end
  describe 'ルート登録(new)ページのテスト' do
    describe 'ログインしている時' do
      before{ sign_in user}
      context 'ルート登録ページの表示' do
        it '成功する' do
          get new_route_path
          expect(response).to have_http_status(:success)
        end
      end
    end
    describe '未ログインの時' do
      context 'ルート登録ページの表示' do
        it '失敗してログインページへリダイレクトする' do
          get new_route_path
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to include('アカウント登録もしくはログインしてください')
        end
      end
    end

  end
  describe 'ルート新規登録(create)機能のテスト' do
    describe 'ログインしている時' do
      before{ sign_in user }
      context '必須情報を入力した状態で新規ルート登録リクエスト' do
        it '成功する' do
          post routes_path, params: route_params
          expect(response).to have_http_status(302)
          expect(response).to redirect_to edit_route_path(Route.last)
        end
      end
      context 'タイトル未入力状態で新規ルート登録リクエスト' do
        it '失敗する' do
          post routes_path, params: invalid_route_params
          expect(response).to have_http_status(200)
          expect(response.body).to include('を入力してください')
        end
      end
    end
    describe '未ログインの時' do
      context '必須情報を入力した状態で新規ルート登録リクエスト' do
        it '失敗する' do
          post routes_path, params: route_params
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to include('アカウント登録もしくはログインしてください')
        end
      end
    end

  end
  describe 'ルート詳細(show)ページのテスト' do
    # routeを公開しておく
    before { route.update(status: true) }
    describe 'ログインしている時' do
      before { sign_in user }
      context 'ルート詳細ページへの表示' do
        it '成功する' do
          get route_path route.id
          expect(response).to have_http_status(:success)
        end
      end
    end
    describe '未ログインの時でも' do
      context 'ルート詳細ページへの表示' do
        it '成功する' do
          get route_path route.id
          expect(response).to have_http_status(:success)
        end
      end
    end

  end
  describe 'ルート編集(edit)ページのテスト' do
    describe 'ログインしている時' do
      before{ sign_in user}
      context 'ルート編集ページの表示' do
        it '成功する' do
          get edit_route_path route.id
          expect(response).to have_http_status(:success)
        end
      end
    end
    describe '未ログインの時' do
      context 'ルート編集ページの表示' do
        it '失敗してログインページへリダイレクトする' do
          get edit_route_path route.id
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to include('アカウント登録もしくはログインしてください')
        end
      end
    end
  end

# =======================spotが登場==========================

  let(:spot_1) { Spot.create(route_id: route.id) }
  let(:spot_2) { Spot.create(route_id: route.id) }
  let(:nil_place_params) {{ spots: { "#{spot_1.id}" => { place_id: spot_1.place , memo: 'スポット1'}, "#{spot_2.id}" => { place_id: spot_2.place , memo: 'スポット2'}}}}
  let(:exist_place_params) {{ spots: { "#{spot_1.id}" => { place_id: 1 , memo: 'スポット1'}, "#{spot_2.id}" => { place_id: 2 , memo: 'スポット2'}}}}
  let(:nil_place_req_params) { route_params.merge(nil_place_params) }
  let(:exist_place_req_params) { route_params.merge(exist_place_params) }

  describe 'ルート下書き保存(draft)機能のテスト' do
    describe 'ログインしている時' do
      before{ sign_in user }
      context 'place_idがnilの状態でもルートの下書き保存は' do
        it '成功する' do
          patch route_draft_path route, params: nil_place_req_params
          expect(response).to have_http_status(302)
        end
      end
    end
    describe '未ログインの時' do
      context 'ルートの下書き保存は' do
        it '失敗してログインページへリダイレクトする' do
          patch route_draft_path route, params: nil_place_req_params
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to include('アカウント登録もしくはログインしてください')
        end
      end
    end
  end

  describe 'ルート全体公開(release)機能のテスト' do
    describe 'ログインしている時' do
      before{ sign_in user }
      context 'place_idがnilの状態だとルートの公開は' do
        it '失敗する' do
          patch route_release_path route, params: nil_place_req_params
          expect(response).to have_http_status(302)
          # expect(response).to redirect_to edit_route_path(route.id)
          expect(flash[:alert]).to include('プレイスが未登録のスポットがあります')
        end
      end
      context 'place_idが登録されていればルートの公開は' do
        it '成功する' do
          patch route_release_path route, params: exist_place_req_params
          expect(response).to have_http_status(302)
          expect(response).to redirect_to route_path(route.id)
          expect(flash[:notice]).to include('公開が完了しました！')
        end
      end
    end
    describe '未ログインの時' do
      context 'ルートの公開は' do
        it '失敗してログインページへリダイレクトする' do
          patch route_release_path route, params: exist_place_req_params
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to include('アカウント登録もしくはログインしてください')
        end
      end
    end
  end

  describe 'ルート削除(delete)機能のテスト' do
    describe 'ログインしている時' do
      before{ sign_in user}
      context 'ルートの削除は' do
        it '成功する' do
          delete route_path route
          expect(response).to have_http_status(302)
        end
      end
    end
    describe '未ログインの時' do
      context 'ルートの削除は' do
        it '失敗してログインページへリダイレクトする' do
          delete route_path route
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to include('アカウント登録もしくはログインしてください')
        end
      end
    end
  end
end
class Publics::RoutesController < ApplicationController
  protect_from_forgery
  before_action :authenticate_user!,only: [:new,:edit,:create,:draft,:release,:destroy]
  before_action :find_route,only: [:show,:edit,:draft,:release,:destroy]
  def new
    @route = Route.new
  end

  def create
    @route = Route.new(route_params)
    if @route.save
      redirect_to edit_route_path(@route)
      flash[:notice] = "保存しました"
    else
      render:new
    end
  end

  def index
    @routes = Route.released
    @routes_left,@routes_center,@routes_right = Route.grid_contents(@routes)
  end

  def show
    if @route.status == false
      redirect_to routes_path
      flash[:alert] = "非公開に設定されています"
    end
    # mapを表示するjsで使うための変数
    gon.places = @route.spots.map{|spot| spot.place}
    gon.spots = @route.spots
  end

  def edit
    @route.spots.create if @route.spots.blank?
  end

  def draft #更新内容を下書き保存
    @route.spots.map do |rsi|
      rsi.update(route_spot_params(rsi.id))
    end

    @route.update(status: false) #route.statusはfalse(下書き)に
    @route.update(route_params)
    redirect_to routes_path,notice: "下書きに保存しました！"
  end

  def release #更新内容を保存して公開
    # spotのmemoや、紐づくplaceの情報を保存
    @route.spots.map do |rsi|
      rsi.update(route_spot_params(rsi.id))
    end
    if @route.spot_place_nil? #placeと紐づいてないspotがあったら公開失敗
      redirect_back(fallback_location: root_path)
      flash[:alert] = "プレイスが未登録のスポットがあります"
    else
      @route.spots.order_update(@route.spots) #route.spotに通し番号を振り直す
      @route.update(status: true) #ステータスを「公開」にする
      @route.update(route_params)
      redirect_to @route,notice: "公開が完了しました！"
    end
  end

  def destroy
    if @route.destroy
      redirect_back(fallback_location: root_path)
    else
      @user = current_user
      render 'users/routes'
    end
  end


  private

  def find_route
    @route = Route.find(params[:id])
  end

  def route_params
    params.require(:route).permit(:title,:explanation,:user_id)
  end

  def route_spot_params(spot_id)
    params.require(:spots).require(spot_id.to_s).permit(:place_id,:memo)
  end
end

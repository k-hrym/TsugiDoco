class Publics::RoutesController < ApplicationController
  protect_from_forgery
  before_action :authenticate_user!,only: [:new,:edit,:create,:control]
  before_action :find_route,only: [:show,:edit,:draft,:release,:destroy]
  def new
    @route = Route.new
  end

  def create
    @route = Route.new(route_params)
    if @route.save
      redirect_to edit_route_path(@route)
    else
      render:new
    end
  end

  def index
    routes = Route.released
    @routes_left = [] #左列用の配列
    @routes_center = [] #真ん中列用の配列
    @routes_right = [] #右列用の配列
    n = 1
    routes.map do |route|
      case n
      when 1
        @routes_left << route
        n += 1
      when 2
        @routes_center << route
        n += 1
      when 3
        @routes_right << route
        n = 1
      end
    end
  end

  def show
    if @route.status == false
      redirect_to routes_path
      flash[:notice] = "非公開に設定されています"
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
    if @route.update(status: false) && @route.update(route_params) #route.statusはfalseに
      redirect_to routes_path,notice: "下書きに保存しました！"
    else
      redirect_back(fallback_location: root_path)
      flash[:notice] = "場所が未登録のスポットがあります"
    end
  end

  def release #更新内容を保存して公開
    @route.spots.map do |rsi|
      rsi.update(route_spot_params(rsi.id))
    end
    unless @route.spots.pluck(:place_id).include?(nil) #placeと紐づいてないspotがあったら公開失敗
      @route.update(status: true)
      @route.update(route_params)
      redirect_to @route,notice: "公開が完了しました！"
    else
      redirect_back(fallback_location: root_path)
      flash[:notice] = "場所が未登録のスポットがあります"
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

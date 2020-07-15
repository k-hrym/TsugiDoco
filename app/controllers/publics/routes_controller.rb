class Publics::RoutesController < ApplicationController
  before_action :authenticate_user!,only: [:new,:edit,:create]
  before_action :find_route,only: [:show,:edit,:draft,:release]
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
    @routes = Route.released
  end

  def show
  end

  def edit
    @route.spots.create if @route.spots.blank?
  end

  def draft #更新内容を下書き保存
    route_spot_ids = @route.spots.pluck(:id)
    route_spot_ids.each do |rsi|
      Spot.find(rsi).update(route_spot_params(rsi))
    end
    if @route.update(status: false) && @route.update(route_params) #route.statusはfalseに
      redirect_to @route,notice: "下書きに保存しました！"
    else
      render :edit,notice: "下書き保存に失敗しました"
    end
  end

  def release #更新内容を保存して公開
    route_spot_ids = @route.spots.pluck(:id)
    route_spot_ids.each do |rsi|
      Spot.find(rsi).update(route_spot_params(rsi))
    end
    if @route.update(status: true) && @route.update(route_params) #route.statusはtrueに
      redirect_to @route,notice: "公開が完了しました！"
    else
      render :edit,notice: "公開に失敗しました"
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

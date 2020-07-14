class Publics::RoutesController < ApplicationController
  before_action :authenticate_user!,only: [:new,:edit,:create]
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
  end

  def show
  end

  def edit
    @route = Route.find(params[:id])
    @route.spots.create if @route.spots.blank?
  end

  def update_all
    @route = Route.find(params[:id])
    route_spot_ids = @route.spots.pluck(:id)
    route_spot_ids.each do |rsi|
      Spot.find(rsi).update(route_spot_params(rsi))
    end
  end

  private

  def route_params
    params.require(:route).permit(:title,:explanation,:user_id)
  end

  def route_spot_params(spot_id)
    params.require(:spots).require(spot_id.to_s).permit(:place_id,:memo)
  end
end

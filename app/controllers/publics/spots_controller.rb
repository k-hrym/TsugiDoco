class Publics::SpotsController < ApplicationController

  def create
    @route = Route.find(params[:id])
    @spot = @route.spots.create
    @route.spots.order_update(@route.spots) #route.spotに通し番号を振り直す
  end

  def destroy
    @route = Route.find(params[:route_id])
    @spot = Spot.find(params[:id])
    if @spot.destroy
      @route.spots.order_update(@route.spots)
    end
  end

  def autocomplete
    places = Place.where('name LIKE ?',"%#{params[:keyword]}%").map do |place|#入力された文字から場所名を検索
      {
        place_id: place.id,
        name: place.name,
        address: place.address
      }
    end
    render json: places.to_json #部分一致で取得した値をjsonにする
  end

  private

  def add_spot_params
    params.permit(:place_id)
  end
end


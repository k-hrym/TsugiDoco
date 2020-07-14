class Publics::SpotsController < ApplicationController
  def add
    @spot = Spot.find(params[:id])
    @spot.update(add_spot_params)
    redirect_back(fallback_location: root_path)
  end

  def create
    @route = Route.find(params[:id])
    @spot = @route.spots.create
    @route.spots.order_update(@route.spots)
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
    # api_spot = ApiSpots.new
    # @suggests = api_spot.suggest(params[:keyword],5)
    # respond_to do |format|
    #   format.json { render autocomplete_spots_path, json: @suggests }
    # end
  end

  private

  def add_spot_params
    params.permit(:place_id)
  end
end


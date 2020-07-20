class Publics::PlacesController < ApplicationController
  before_action :authenticate_user!,only: [:new,:create]
  before_action :valid_genres,only: [:new,:create,:edit,:update]
  before_action :find_place,only: [:show,:edit,:update]

  def new
    @place = Place.new
    @place.place_images.build # PlaceImageのデータを作成
  end

  def create
    @place = Place.new(place_params)
    @place.place_images.map{|pi| pi.user = current_user} # PlaceImageのuser_idに値を渡す
    if @place.save
      redirect_to @place
    else
      render :new
    end
  end

  def index
    @places = Place.all
  end

  def show
    spots = Spot.where(place_id: @place.id)
    # @placeに紐づくSpotが登録されているかを確認
    unless spots.nil?
      #あればその次にいったSpotを配列にして返す
      @next = spots.map do |spot|
        next_spots = []
        route_spots = spot.route.spots
        route_spots.find_by(order: spot.order + 1)
      end
      @next_spots = @next.compact #nilは含めない
    end

    gon.place = @place #map表示用の変数を定義
  end

  def edit
    @place.place_images.build # PlaceImageのデータを作成
  end

  def update
    if @place.update(place_params_without_images) && PlaceImage.add_place_images(place_params[:place_images_images],@place,current_user)
      redirect_to @place
    else
      render :edit
    end
  end

  private

  def place_params
    params.require(:place).permit(:name,:genre_id,:explanation,:postcode,:address,:access,:tel,:url,:hours,:price,:holiday,place_images_images: [])
  end

  def place_params_without_images
    params.require(:place).permit(:name,:genre_id,:explanation,:postcode,:address,:access,:tel,:url,:hours,:price,:holiday,:is_closed)
  end

  def valid_genres
    @genres = Genre.only_valid
  end

  def find_place
    @place = Place.find(params[:id])
  end
end

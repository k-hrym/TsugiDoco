class Publics::PlacesController < ApplicationController
  before_action :authenticate_user!,only: [:new,:create]

  def new
    @place = Place.new
    @place.place_images.build # PlaceImageのデータを作成
    @genres = Genre.only_valid
  end

  def create
    debugger
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
    @place = Place.find(params[:id])
  end

  private

  def place_params
    params.require(:place).permit(:name,:genre_id,:explanation,:postcode,:address,:access,:tel,:url,:hours,:price,:holiday,place_images_images: [])
  end
end

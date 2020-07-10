class Publics::PlacesController < ApplicationController
  def new
    @place = Place.new
    @genres = Genre.only_valid
  end

  def create
    @place = Place.new(place_params)
    if @place.save
      redirect_to places_path
    else
      render :new
    end
  end

  def index
  end

  private

  def place_params
    params.require(:place).permit(:name,:genre_id,:explanation,:postcode,:address,:access,:tel,:url,:hours,:price,:holiday)
  end
end

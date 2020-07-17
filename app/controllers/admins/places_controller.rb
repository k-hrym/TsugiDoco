class Admins::PlacesController < ApplicationController
  layout 'admins'
  def index
    @places = Place.all
  end

  def show
  end

  def edit
    @place = Place.find(params[:id])
    @genres = Genre.only_valid
  end

  def update
    @place = Place.find(params[:id])
    if @place.update(place_params_without_images) && PlaceImage.add_place_images(place_params[:place_images_images],@place,current_user)
      redirect_to admins_place_path(@place)
    else
      render :edit
    end
  end

  def new
  end

  def import
    Place.import(params[:file])
    redirect_to admins_places_path
  end

  private

  def place_params
    params.require(:place).permit(:name,:genre_id,:explanation,:postcode,:address,:access,:tel,:url,:hours,:price,:holiday,place_images_images: [])
  end

  def place_params_without_images
    params.require(:place).permit(:name,:genre_id,:explanation,:postcode,:address,:access,:tel,:url,:hours,:price,:holiday,:is_closed)
  end

end

class Admins::PlacesController < ApplicationController
  before_action :authenticate_admin!
  layout 'admins'
  def index
    @places = Place.all
  end

  def edit
    @place = Place.find(params[:id])
    @genres = Genre.only_valid
  end

  def update
    @genres = Genre.only_valid
    @place = Place.find(params[:id])
    if @place.update(place_params_without_images) && PlaceImage.add_place_images(params[:place][:place_images_images],@place,current_user)
      redirect_to admins_places_path
      flash[:notice] = "保存しました"
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

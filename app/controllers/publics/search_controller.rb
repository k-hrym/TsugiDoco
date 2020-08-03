class Publics::SearchController < ApplicationController
  def search
    @places = Place.search(params[:search])
    @routes = Route.search(params[:search])
  end

  def image_search
    @places = PlaceImage.image_search(image_search_params[:image])
  end

  private

  def image_search_params
    params.require(:place_image).permit(:image)
  end
end

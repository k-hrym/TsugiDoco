class Publics::SearchController < ApplicationController
  def search
    @places = Place.search(params[:search])
    @routes = Route.search(params[:search])
  end
end

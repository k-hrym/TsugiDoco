class HomeController < ApplicationController
  def top
    @routes = Route.released.take(4)
    @places = Place.all.take(5)
  end

  def about
  end
end

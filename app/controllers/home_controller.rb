class HomeController < ApplicationController
  def top
    @routes = Route.released.take(4)
    @places = Place.all.reverse_order.take(5)
  end

  def about
  end
end

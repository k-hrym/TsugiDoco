class HomeController < ApplicationController
  def top
    @routes = Route.released.reverse_order.take(4)
    @places = Place.all.reverse_order.take(6)
  end

  def about
  end
end

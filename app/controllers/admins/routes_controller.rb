class Admins::RoutesController < ApplicationController
  layout 'admins'
  def index
    @routes = Route.all.reverse_order
  end

  def show
    @route = Route.find(params[:id])
  end
end

class Admins::RoutesController < ApplicationController
  before_action :authenticate_admin!
  layout 'admins'
  def index
    @routes = Route.all.reverse_order
  end

  def show
    @route = Route.find(params[:id])
  end
end

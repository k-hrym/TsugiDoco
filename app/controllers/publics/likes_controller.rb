class Publics::LikesController < ApplicationController
  def create
    @route = Route.find(params[:route_id])
    like = Like.new(route_id: @route.id,user_id: current_user.id)
    like.save
  end

  def destroy
    @route = Route.find(params[:route_id])
    like = Like.find_by(route_id: @route.id,user_id: current_user.id)
    like.destroy
  end
end

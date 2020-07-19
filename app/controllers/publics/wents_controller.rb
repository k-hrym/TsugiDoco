class Publics::WentsController < ApplicationController
  def create
    @user = current_user
    @place = Place.find(params[:id])
    @user.wents.find_or_create_by(place_id: @place.id)
  end

  def destroy
    @user = current_user
    @place = Place.find(params[:id])
    @user.wents.find_by(place_id: @place.id).destroy
  end
end

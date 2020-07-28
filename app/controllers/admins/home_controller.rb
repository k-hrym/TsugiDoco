class Admins::HomeController < ApplicationController
  before_action :authenticate_admin!
  layout 'admins'
  def top
    @places = Place.all
    @places_today = Place.all_day
    @places_thisweek = Place.all_week
    @places_thismonth = Place.all_month

    @routes = Route.all
    @routes_today = Route.all_day
    @routes_thisweek = Route.all_week
    @routes_thismonth = Route.all_month

    @genres = Genre.all
    @genres_today = Genre.all_day
    @genres_thisweek = Genre.all_week
    @genres_thismonth = Genre.all_month

    @users = User.all
    @users_today = User.all_day
    @users_thisweek = User.all_week
    @users_thismonth = User.all_month
  end
end

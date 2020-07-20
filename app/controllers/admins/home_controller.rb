class Admins::HomeController < ApplicationController
  before_action :authenticate_admin!
  layout 'admins'
  def top
  end
end

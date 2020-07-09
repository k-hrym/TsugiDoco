class Publics::UsersController < ApplicationController
  before_action :find_user,only: [:show,:edit,:update]
  before_action :valid_user?,only: [:edit]

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:profile,:email,:birth,:sex,:profile_image)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def valid_user?
    @user == current_user
  end
end

class Admins::UsersController < ApplicationController
  before_action :authenticate_admin!
  layout 'admins'
  def index
    @users = User.all.reverse_order
  end

  def show
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(edit_valid)
    redirect_to admins_users_path
  end

  private

  def edit_valid
    params.require(:user).permit(:is_valid)
  end
end

class Publics::RelationsController < ApplicationController
  def create
    @other_user = User.find(params[:id])
    unless current_user.follow(@other_user)
      redirect_back(fallback_location: root_path)
      flash[:notice] = "フォローできませんでした"
    end
  end

  def destroy
    @other_user = User.find(params[:id])
    unless current_user.unfollow(@other_user)
      redirect_back(fallback_location: root_path)
      flash[:notice] = "フォローを外せませんでした"
    end
  end

  def following
    @user = User.find(params[:user_id])
  end

  def follower
    @user = User.find(params[:user_id])
  end
end

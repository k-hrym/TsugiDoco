class Publics::UsersController < ApplicationController
  before_action :find_user,only: [:show,:edit,:update,:hide]
  before_action :user_self?,only: [:edit,:hide,:update,:routes]
  before_action :valid_user?,only: [:show]

  def show
    # 公開済のルート
    @routes = Route.where(user_id: @user.id,status: true)
    # いいねしたルート
    @like_routes = @user.likes.map{|like| like.route}
    # いきたい登録したプレイス
    @wishes_places = @user.wishes.map{|wish| wish.place}
    # いった登録したプレイス
    @wents_places = @user.wents.map{|went| went.place}
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user
      flash[:notice] = "保存しました"
    else
      render :edit
    end
  end

  def routes
    @user = current_user
    @routes = @user.routes
  end

  def switch_table
    @user = current_user
    if params[:published] =="true"
      @routes = @user.routes.where(status: true)
    elsif params[:published] == "false"
      @routes = @user.routes.where(status: false)
    else
      @routes = @user.routes
    end
  end

  def hide
    @user.update(is_valid: false)
    reset_session
    flash[:notice] = "ご利用ありがとうございました。"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name,:profile,:email,:birth,:sex,:profile_image)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def user_self?
    @user == current_user
  end

  def valid_user?
    unless @user.is_valid == true
      redirect_back(fallback_location: root_path)
      flash[:alert] = "存在しないユーザーです"
    end
  end
end

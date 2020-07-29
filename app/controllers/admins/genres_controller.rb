class Admins::GenresController < ApplicationController
  before_action :authenticate_admin!
  layout 'admins'
  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admins_genres_path
      flash[:notice] = "保存しました"
    else
      render :new
    end
  end

  def index
    @genres = Genre.all
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admins_genres_path
      flash[:notice] = "保存しました"
    else
      debugger
      render :edit
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name,:is_valid)
  end
end

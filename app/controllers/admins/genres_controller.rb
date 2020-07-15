class Admins::GenresController < ApplicationController
  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admins_genres_path
    else
      render :new
    end
  end

  def index
    @genres = Genre.only_valid
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end

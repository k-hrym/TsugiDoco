class Publics::PlacesController < ApplicationController
  before_action :authenticate_user!,only: [:new,:create,:edit,:update]
  before_action :valid_genres,only: [:new,:create,:edit,:update]
  before_action :find_place,only: [:show,:edit,:update]

  def new
    @place = Place.new
    @place.place_images.build # PlaceImageのデータを作成
  end

  def create
    @place = Place.new(place_params)
    @place.place_images.map{|pi| pi.user = current_user} # PlaceImageのuser_idに値を渡す
    if @place.save
      redirect_to @place
      flash[:notice] = "保存しました"
    else
      render :new
    end
  end

  def index
    @places = Place.all
  end

  def show
    # 次、どこ行く？に表示するplaceをspotsから取得
    spots = Spot.where(place_id: @place.id)
    @next_spots = Spot.find_next_spots(spots)
    # アップロードされている画像にタグ付されたタグを抽出して先頭から5個を渡す。
    @tags = @place.with_tags.take(5)
    # map表示用の変数を定義
    gon.place = @place
  end

  def edit
    @place.place_images.build # PlaceImageのデータを作成
  end

  def update
    # place_images.newで作成しておくとupdateで一緒に保存される。
    unless params[:place][:place_images_images].nil?
      @place.add_place_images(params[:place][:place_images_images],current_user)
    end
    if @place.update(place_params_without_images)
      redirect_to @place
      flash[:notice] = "保存しました"
    else
      render :edit
    end
  end

  private

  def place_params
    params.require(:place).permit(:name,:genre_id,:explanation,:postcode,:address,:access,:tel,:url,:hours,:price,:holiday,place_images_images: [])
  end

  def place_params_without_images
    params.require(:place).permit(:name,:genre_id,:explanation,:postcode,:address,:access,:tel,:url,:hours,:price,:holiday,:is_closed)
  end

  def valid_genres
    @genres = Genre.only_valid
  end

  def find_place
    @place = Place.find(params[:id])
  end
end

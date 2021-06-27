class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!


  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(params_genre)
    @genres = Genre.all
    if @genre.save
      flash[:notice] = "ジャンルを追加しました"
      redirect_to admin_genres_path
    else
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(params_genre)
      flash[:success] = "ジャンルを変更しました"
      redirect_to admin_genres_path
    else
      render :edit
    end
  end

  private

  def params_genre
    params.require(:genre).permit(:name)
  end
end
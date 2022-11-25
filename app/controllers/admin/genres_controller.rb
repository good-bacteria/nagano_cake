class Admin::GenresController < ApplicationController
  
  def index
    @genre = Genre.new
    @genres = Genre.page(params[:page]).per(10)
  end
  
  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:genre_notice] = "ジャンルの新規登録に成功しました"
      redirect_to admin_genres_path
    else
      @genres = Genre.page(params[:page]).per(10)
      render "index"
    end
  end
  
  def edit
    @genre = Genre.find(params[:id])
  end
  
  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:genre_notice] = "ジャンルの編集に成功しました"
      redirect_to admin_genres_path
    else
      render "edit"
    end
  end
  
  private
  
  def genre_params
    params.require(:genre).permit(:name)
  end
end

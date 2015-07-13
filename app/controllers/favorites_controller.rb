class FavoritesController < ApplicationController
  def index
  	@favorites = Favorite.all
  end

  def show
  	@favorite = Favorite.find(params[:id])
  end

  def new
  	@favorite = Favorite.new
  end

  def edit
  end

   def create
    @favorite = Favorite.new(favorite_params)

    if @favorite.save
      redirect_to lists_url
    else
      render :new
    end
  end

  private
  def favorite_params
    params.require(:favorite).permit(:user_id, :bookmark_id, :list_id)
  end

end

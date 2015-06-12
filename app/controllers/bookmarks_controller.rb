class BookmarksController < ApplicationController
  def index
    @bookmarks = Bookmark.all
  end

  def show
    @bookmark = Bookmark.find(params[:id])

    if current_user
      @note = @bookmark.notes.build
    end
  end

  def new
    @bookmark = Bookmark.new
  end

  def edit
  end

   def create
    @bookmark = Bookmark.new(bookmark_params)

    if @bookmark.save
      redirect_to bookmarks_url
    else
      render :new
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:url, :description, :user_id, :list_id, :title, :image, :summary)
  end
end

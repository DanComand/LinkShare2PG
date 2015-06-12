class BookmarksController < ApplicationController
  def index
    @bookmarks = Bookmark.all
  end

  def show
  end

  def new
    @bookmark = Bookmark.new
  end

  def edit
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:url, :description, :user_id, :list_id, :title, :image, :summary)
  end
end

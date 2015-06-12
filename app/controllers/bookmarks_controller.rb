class BookmarksController < ApplicationController

  before_filter :ensure_logged_in, only: [:index, :create, :destroy]

  def index
    @bookmarks = current_user.bookmarks.order(created_at: :desc)
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
    @bookmark.user_id = current_user.id

    meta = MetaInspector.new(@bookmark.url)
    @bookmark.title = meta.title
    @bookmark.image = meta.images.best
    @bookmark.summary = meta.description


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

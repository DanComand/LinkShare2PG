class BookmarksController < ApplicationController
  before_filter :ensure_logged_in, only: [:index, :create, :destroy]


  def index
    @bookmarks = current_user.bookmarks.order(created_at: :desc)
    @bookmarkslatest = @bookmarks.where('created_at > ?', 1.days.ago)
  end


  def show
     @bookmarks = Bookmark.find(params[:id])
     @bookmarkslatest = @bookmarks.where('created_at > ?', 1.days.ago)
     @lists = List.all
  end

  def new
    @bookmark = Bookmark.new
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def create
    @list = List.find(params[:list_id])
    @bookmark = @list.bookmarks.build(bookmark_params)
    @bookmark.user_id = current_user.id

    meta = MetaInspector.new(@bookmark.url)
    @bookmark.title = meta.title
    @bookmark.image = meta.images.best
    @bookmark.summary = meta.description

    if @bookmark.save

      redirect_to list_url(@list)
    else
      render :new
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_url(@bookmark.list)
  end

  def update
    @bookmark = Bookmark.find(params[:id])

    if @bookmark.update_attributes(bookmark_params)
      redirect_to bookmark_path(@bookmark)
    else
      render :edit
    end
  end

  private
  def bookmark_params
    params.require(:bookmark).permit(:url, :description, :user_id)
  end


end
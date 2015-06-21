class ListsController < ApplicationController
  before_filter :ensure_logged_in, only: [:index, :show, :create, :destroy]

  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
    @bookmarks = @list.bookmarks.order(created_at: :desc)
    @lists = List.all
    @bookmarkslatest = @bookmarks.where('created_at > ?', 1.days.ago)
  end

  def new
    @list = List.new
    @bookmarks = @list.bookmarks.order(created_at: :desc)
    @bookmarkslatest = @bookmarks.where('created_at > ?', 1.days.ago)
  end

  def create
    @list = List.new(list_params)
    @list.user_id = current_user.id
    if @list.save
      redirect_to lists_path, notice: "List Created! Now add some links!"
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to lists_path

  end

  def edit
  end

  private

  def list_params
    params.require(:list).permit(:name, :user_id)
  end
end
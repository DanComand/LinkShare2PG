class ListsController < ApplicationController
  before_filter :ensure_logged_in, only: [:index, :show, :create, :destroy]

  def index
    @lists = List.all
    @dailylist = Bookmark.where(updated_at: (Time.now - 24.hours)..Time.now)
  end

  def show
    @list = List.find(params[:id])
    @bookmarks = @list.bookmarks.order(created_at: :desc)
    @lists = List.all
  end

  def new
    @list = List.new
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
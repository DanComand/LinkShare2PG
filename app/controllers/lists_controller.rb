class ListsController < ApplicationController
  before_filter :ensure_has_invite, only: [:show]
  before_filter :ensure_logged_in, only: [:index, :create, :destroy]

  def index
    @list = current_user.lists
  end

  def show
    @list = List.find(params[:id])
    @bookmarks = @list.bookmarks.order(created_at: :desc)
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

  def edit
  end

  private

  def list_params
    params.require(:list).permit(:name, :user_id)
  end

  def ensure_has_invite
    @list = List.find(params[:id])
    unless Invite.where(email: current_user.email).find_by_list_id(params[:id]) or @list.user == current_user
      redirect_to lists_url

    end
  end
end
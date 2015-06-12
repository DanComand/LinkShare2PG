class NotesController < ApplicationController
  before_filter :load_bookmark

  def show
    @note = Note.find(params[:id])
  end

  def create
    @note = @bookmark.notes.build(notes_params)
    @note.bookmark = current_user

    if @note.save
      redirect_to bookmarks_path, notice: "Comment saved!"
    else
      render 'bookmarks/show'
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
  end

  private
  def review_params
    params.require(:review).permit(:comment, :bookmark_id)
  end

end

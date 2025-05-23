class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  def index
    @notes = Note.all
  end

  def show
  end

  def new
    @note = current_user.notes.build
  end

  def edit
  end

  def create
    @note = current_user.notes.build(note_params)
    respond_to do |format|
      if @note.save
        format.html { redirect_to note_url(@note), notice: 'Note was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @note.update(note_params)
      redirect_to @note, notice: 'Note was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @note.destroy
    redirect_to notes_url, notice: 'Note was successfully destroyed.'
  end

  private

  def set_note
    @note = Note.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:title, :content, :user_id)
  end
end

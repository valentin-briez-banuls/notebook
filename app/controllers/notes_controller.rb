class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  skip_forgery_protection only: [:new,:edit]
  # protect_from_forgery except: :edit
  def index
    @notes = Note.all
  end

  def show
  end

  def new
    @note = Note.new
    respond_to do |format|
      format.js { render :form }
    end
  end

  def edit
    @note = Note.find(params[:id])
    respond_to do |format|
      format.js { render :form }
    end
  end

  def create
    @note = current_user.notes.build(note_params)
    respond_to do |format|
      if @note.save
        format.js
        format.html { redirect_to note_url(@note), notice: 'Note was successfully created.' }
      else
        format.js { render :form, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @note.update(note_params)
        format.js
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
      else
        format.js { render :form, status: :unprocessable_entity }
        format.html { render :edit }
      end
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

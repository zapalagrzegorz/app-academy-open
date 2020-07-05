# frozen_string_literal: true

class NotesController < ApplicationController
  def create
    @track = Track.find(params[:id])
    @note = @track.notes.new(notes_params)
    @note.user_id = current_user.id
    @note.save

    redirect_to track_path
  end

  # every user could destroy notes!
  def destroy
    @note = current_user&.notes&.find_by(params[:id])

    if @note
      @note.destroy
      flash[:success] = 'Note was successfully deleted.'
      redirect_to track_path(params[:track_id])
    else
      render plain: "You're not authorized", status: 403
    end
  end

  def notes_params
    params.require(:notes).permit(:content)
  end
end

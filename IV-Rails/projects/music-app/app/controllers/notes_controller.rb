# frozen_string_literal: true

class NotesController < ApplicationController
  def create
    @track = Track.find(params[:id])
    @note = @track.notes.new(notes_params)
    @note.user_id = current_user.id
    @note.save

    redirect_to track_path
  end

  def notes_params
    params.require(:notes).permit(:content)
  end
end

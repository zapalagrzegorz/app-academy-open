# frozen_string_literal: true

class NotesController < ApplicationController
  def create
    # komentarz musi należeć do zalogowanego użytkownika
    # parametr nie pochodzi od "użytkownika"
    # much simpler
    # current_user.notes.new(notes_params)

    track = Track.find(params[:id])
    note = track.notes.new(notes_params)
    note.user_id = current_user.id
    note.save

    redirect_to track_path(note.track_id)
  end

  # every user could destroy notes!
  # to mogłoby sypać błędami czyli metoda find - bo akcja niedozwolona
  def destroy
    # nie mogę użyć current_user&.notes&.find
    # a na debuggerze szło
    note = current_user.notes.find(params[:id])

    if note
      note.destroy
      flash[:success] = 'Note was successfully deleted.'
      redirect_to track_path(note.track_id)
    else
      render plain: "You're not authorized", status: 403
    end
  end

  def notes_params
    params.require(:notes).permit(:content)
  end
end

# frozen_string_literal: true

require 'bcrypt'
class User < ApplicationRecord
  validates :email, :session_token, presence: true, uniqueness: true

  # password jest dostępny tylko w modelu, nie ma go w bazie
  # nie mniej jest walidacja back-end'owa
  validates :password, length: { minimum: 6, maximum: 20, allow_nil: true }

  # ?? gdy hasło nie zostanie zapisane

  validates :password_hash, presence: { message: 'Password cannot be blank' }

  # has_many :todos, class_name: 'todo'

  # gdyby to była klasa statyczna
  # wywołanie jej w ramach obiektu to:
  # self.class.generate_session_token
  def generate_session_token
    # najprostsza forma:
    # SecureRandom.urlsafe_base64

    # zapobiegaj duplikatom
    begin
      token = SecureRandom.urlsafe_base64(16)
    end while User.exists?(session_token: token)

    token
  end

  def reset_session_token!
    # @ - instance variable. powiązana z obiektem, ale nie w bazie. Można wywołać ją np. innej metodzie
    # w kontrolerze zmienne instacji są dostępne dla widoku
    # https://stackoverflow.com/questions/6327174/rails-self-vs i linki do postów
    # @ doesn't work here because ActiveRecord doesn't pay attention to your instance variables,
    # the method call works because AR added that as a way to change the encrypted_password property. AR's properties are separate from your object's instance variables. – mu is too short Jun 13 '11 at 6:43

    # bez self to może być local variable (choć Rails powinien sprawdzić czy istnieje taki atrybut z bazy), która żyje tylko do końca metody. Sugeruje się dodawanie self dla atrybutów
    self.session_token = generate_session_token

    # not persisted! need to save change of state
    # tu np. też jest self.save! ale Rubocop łapie, że to jest redundant
    save!
    
    self.session_token
    # session[:session_token] = nil
  end
end

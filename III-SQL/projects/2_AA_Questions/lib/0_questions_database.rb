# frozen_string_literal: true

require 'singleton'
require 'sqlite3'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  SQL_FILE = File.join(File.dirname(__FILE__), 'aa_questions.sql')

  DB_FILE = File.join(File.dirname(__FILE__), 'aa_questions.db')

  def self.reset!
    "rm '#{DB_FILE}'",
    "cat '#{SQL_FILE} | sqlite3 '#{DB_FILE}" 
    
    commands.each{ |command| `#{command}`}
    QuestionsDatabase.open
  end

  def self.open
    @database = SQLite3::Database.new(DB_FILE)
    @database.results_as_hash = true
    @database.type_translation = true
  end

  def self.execute(*args)
    instance.execute(*args)
  end
  
  def initialize; end
end

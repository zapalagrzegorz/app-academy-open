# frozen_string_literal: true

require 'active_support/inflector'

class ModelBase
  def self.table
    to_s.tableize
  end

  def self.find_by_id(id)
    item = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM #{table}
      WHERE id = ?
    SQL

    return nil unless item.first

    new(item.first)
  end
end

class CreateTaggings < ActiveRecord::Migration[5.2]
  def change
    create_table :taggings do |t|

      t.timestamps

      t.belongs_to :todo, index: true, foreign_key: true
      t.belongs_to :tag, index: true, foreign_key: true
    end
  end
end

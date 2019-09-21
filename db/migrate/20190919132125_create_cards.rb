class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string :card_word
      t.string :card_def
      t.belongs_to :setbox, foreign_key: true

      t.timestamps
    end
  end
end

class CreateGameRecords < ActiveRecord::Migration
  def change
    create_table :game_records do |t|
      t.string :name
      t.timestamp :timestamp

      t.timestamps null: false
    end
  end
end

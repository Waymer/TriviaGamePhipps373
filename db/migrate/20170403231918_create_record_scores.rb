class CreateRecordScores < ActiveRecord::Migration
  def change
    create_table :record_scores do |t|
      t.integer :gr_id
      t.integer :qs_id

      t.timestamps null: false
    end
  end
end

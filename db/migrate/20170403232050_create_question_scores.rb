class CreateQuestionScores < ActiveRecord::Migration
  def change
    create_table :question_scores do |t|
      t.integer :score
      t.integer :time
      t.integer :landmark_id
      t.integer :question_id
      t.integer :game_record_id
      t.timestamps null: false
    end
  end
end

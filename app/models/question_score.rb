class QuestionScore < ActiveRecord::Base
	#Relationships
	belongs_to :game_record
	#Scopes
	scope :for_game_record, ->(game_record_id) { where('game_record_id = ?', game_record_id) }
	scope :for_landmark, ->(landmark_id) { where('landmark_id = ?', landmark_id) }
	scope :for_question, ->(question_id) { where('question_id = ?', question_id) }
	scope :by_landmark_id, -> { order("landmark_id") }
	scope :by_question_id, -> { order("question_id") }
	#Validations
	validates_presence_of :landmark_id
	validates_presence_of :question_id
	#Methods
end

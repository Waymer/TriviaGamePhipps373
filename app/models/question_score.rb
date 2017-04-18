class QuestionScore < ActiveRecord::Base
	#Relationships
	belongs_to :game_record
	#Scopes
	scope :for_game_record, ->(gr_id) { where('gr_id = ?', gr_id) }
	#Validations
	validates_presence_of :landmark_id
	validates_presence_of :question_id
	#Methods
end

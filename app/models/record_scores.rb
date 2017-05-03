class RecordScore < ActiveRecord::Base
	#Relationships
	belongs_to :game_record
	belongs_to :question_score
	
	#Scopes
	scope :for_game_record, ->(game_record_id) { joins(:record_score).where('gr_id = ?', game_record_id) }
	#Validations

	#Methods
end

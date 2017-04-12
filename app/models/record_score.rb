class RecordScore < ActiveRecord::Base
	#Relationships
	belongs_to :game_record
	belongs_to :question_score
	
	#Scopes

	#Validations

	#Methods
end

class GameRecord < ActiveRecord::Base
	#Relationships
	has_many :record_scores

	#Scopes

	#Validations
	#should we include this, if name might not be entered until end??
	validates_presence_of :name
	#considered different from rails generated id??
	validates_presence_of :gr_id
	#Methods

	def get_total_score
		related_record_scores = Record_score.for_game_record(self.gr_id)
		related_question_scores_id = related_record_scores.map{|n| n.qs_id}
		#related_question_scores = Array.new
		score = 0
		related_question_scores_id.length.times do |j|
			score += Question_score.for_specific(related_question_scores_id[j]).score
		end
		score
	end

	def get_total_time
		related_record_scores = Record_score.for_game_record(self.gr_id)
		related_question_scores_id = related_record_scores.map{|n| n.qs_id}
		time = 0
		related_question_scores_id.length.times do |j|
			time += Question_score.for_specific(related_question_scores_id[j]).time
		end
		time
	end
end

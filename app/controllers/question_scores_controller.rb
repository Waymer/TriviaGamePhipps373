class QuestionScoresController < ApplicationController
  before_action :set_question_score, only: [:show, :edit, :update, :destroy]

  # GET /question_scores
  # GET /question_scores.json
  def index
    @question_scores = QuestionScore.all
  end

  # GET /question_scores/1
  # GET /question_scores/1.json
  def show
  end

  # GET /question_scores/new
  def new
    @question_score = QuestionScore.new
  end

  # GET /question_scores/1/edit
  def edit
  end

  # POST /question_scores
  # POST /question_scores.json
  def create
    @question_score = QuestionScore.new(question_score_params)

    respond_to do |format|
      if @question_score.save
        format.html { redirect_to @question_score, notice: 'Question score was successfully created.' }
        format.json { render :show, status: :created, location: @question_score }
      else
        format.html { render :new }
        format.json { render json: @question_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /question_scores/1
  # PATCH/PUT /question_scores/1.json
  def update
    respond_to do |format|
      if @question_score.update(question_score_params)
        format.html { redirect_to @question_score, notice: 'Question score was successfully updated.' }
        format.json { render :show, status: :ok, location: @question_score }
      else
        format.html { render :edit }
        format.json { render json: @question_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /question_scores/1
  # DELETE /question_scores/1.json
  def destroy
    @question_score.destroy
    respond_to do |format|
      format.html { redirect_to question_scores_url, notice: 'Question score was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question_score
      @question_score = QuestionScore.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_score_params
      params.require(:question_score).permit(:score, :time, :landmark_id, :question_id)
    end
end

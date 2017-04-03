class RecordScoresController < ApplicationController
  before_action :set_record_score, only: [:show, :edit, :update, :destroy]

  # GET /record_scores
  # GET /record_scores.json
  def index
    @record_scores = RecordScore.all
  end

  # GET /record_scores/1
  # GET /record_scores/1.json
  def show
  end

  # GET /record_scores/new
  def new
    @record_score = RecordScore.new
  end

  # GET /record_scores/1/edit
  def edit
  end

  # POST /record_scores
  # POST /record_scores.json
  def create
    @record_score = RecordScore.new(record_score_params)

    respond_to do |format|
      if @record_score.save
        format.html { redirect_to @record_score, notice: 'Record score was successfully created.' }
        format.json { render :show, status: :created, location: @record_score }
      else
        format.html { render :new }
        format.json { render json: @record_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /record_scores/1
  # PATCH/PUT /record_scores/1.json
  def update
    respond_to do |format|
      if @record_score.update(record_score_params)
        format.html { redirect_to @record_score, notice: 'Record score was successfully updated.' }
        format.json { render :show, status: :ok, location: @record_score }
      else
        format.html { render :edit }
        format.json { render json: @record_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /record_scores/1
  # DELETE /record_scores/1.json
  def destroy
    @record_score.destroy
    respond_to do |format|
      format.html { redirect_to record_scores_url, notice: 'Record score was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_record_score
      @record_score = RecordScore.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def record_score_params
      params.require(:record_score).permit(:gr_id, :qs_id)
    end
end

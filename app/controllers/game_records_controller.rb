class GameRecordsController < ApplicationController
  before_action :set_game_record, only: [:show, :edit, :update, :destroy]

  # GET /game_records
  # GET /game_records.json
  def index
    @game_records = GameRecord.all
  end

  # GET /game_records/1
  # GET /game_records/1.json
  def show
    @related_question_scores = @game_record.question_scores.by_landmark_id
  end

  # GET /game_records/new
  def new
    @game_record = GameRecord.new :timestamp => Time.now.to_i
  end

  # GET /game_records/1/edit
  def edit
  end

  # POST /game_records
  # POST /game_records.json
  def create
    puts game_record_params
    @game_record = GameRecord.new(game_record_params)

    respond_to do |format|
      if @game_record.save
        format.html { redirect_to @game_record, notice: 'Game record was successfully created.' }
        format.js   { }
        format.json { render :show, status: :created, location: @game_record }
      else
        format.html { render :new }
        format.json { render json: @game_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /game_records/1
  # PATCH/PUT /game_records/1.json
  def update
    respond_to do |format|
      if @game_record.update(game_record_params)
        format.html { redirect_to @game_record, notice: 'Game record was successfully updated.' }
        format.js   { }
        format.json { render :show, status: :ok, location: @game_record }
      else
        format.html { render :edit }
        format.json { render json: @game_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game_records/1
  # DELETE /game_records/1.json
  def destroy
    # @game_record.destroy
    # respond_to do |format|
    #   format.html { redirect_to game_records_url, notice: 'Game record was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  def top
    @game_records = GameRecord.all
    @game_scores = Array.new()
    game_score = Array.new()
    for record in @game_records
      game_score = [record.id, record.get_total_score]
      @game_scores << game_score
    end
    @game_scores.sort_by{|s| s[1]}
    @game_scores = @game_scores[0, 10]
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_record
      @game_record = GameRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_record_params
      params.require(:game_record).permit(:name, :timestamp)
    end
end

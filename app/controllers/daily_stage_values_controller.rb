class DailyStageValuesController < ApplicationController
  before_action :set_daily_stage_value, only: [:show, :edit, :update, :destroy]

  # GET /daily_stage_values
  # GET /daily_stage_values.json
  def index
    if params[:task_board_id]
      @daily_stage_values = TaskBoard.find(params[:task_board_id]).daily_stage_values
      @daily_stage_values = @daily_stage_values.where(created_at: 14.day.ago..Date.today)
    else
      @daily_stage_values = DailyStageValue.where(created_at: 14.day.ago..Date.today)
    end
  end

  # GET /daily_stage_values/1
  # GET /daily_stage_values/1.json
  def show
  end

  # GET /daily_stage_values/new
  def new
    @daily_stage_value = DailyStageValue.new
  end

  # GET /daily_stage_values/1/edit
  def edit
  end

  # POST /daily_stage_values
  # POST /daily_stage_values.json
  def create
    @daily_stage_value = DailyStageValue.new(daily_stage_value_params)

    respond_to do |format|
      if @daily_stage_value.save
        format.html { redirect_to @daily_stage_value, notice: 'Daily stage value was successfully created.' }
        format.json { render :show, status: :created, location: @daily_stage_value }
      else
        format.html { render :new }
        format.json { render json: @daily_stage_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /daily_stage_values/1
  # PATCH/PUT /daily_stage_values/1.json
  def update
    respond_to do |format|
      if @daily_stage_value.update(daily_stage_value_params)
        format.html { redirect_to @daily_stage_value, notice: 'Daily stage value was successfully updated.' }
        format.json { render :show, status: :ok, location: @daily_stage_value }
      else
        format.html { render :edit }
        format.json { render json: @daily_stage_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /daily_stage_values/1
  # DELETE /daily_stage_values/1.json
  def destroy
    @daily_stage_value.destroy
    respond_to do |format|
      format.html { redirect_to daily_stage_values_url, notice: 'Daily stage value was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_daily_stage_value
      @daily_stage_value = DailyStageValue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def daily_stage_value_params
      params[:daily_stage_value]
    end
end

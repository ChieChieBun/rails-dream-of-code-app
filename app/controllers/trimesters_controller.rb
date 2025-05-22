class TrimestersController < ApplicationController
before_action :set_trimester, only: %i[ show edit update destroy ]

  def index
    @trimesters = Trimester.all
  end
  def show
  @courses = @trimester.courses
  end
  def new
    @trimester = Trimester.new
  end
  def edit
  end
  def create
    @trimester = Trimester.new(trimester_params)

    respond_to do |format|
      if @trimester.save

        format.html { redirect_to @trimester, notice: "Trimester was successfully created." }
        format.json { render :show, status: :created, location: @trimester }
      else

        format.html { render :new, status: :bad_request }
        format.json { render json: @trimester.errors, status: :bad_request }
      end
    end
  end

  def update
     respond_to do |format|
      if @trimester.update(trimester_params)
        format.html { redirect_to @trimester, notice: "Trimester was successfully updated." }
        format.json { render :show, status: :ok, location: @trimester }
      else
        format.html { render :edit, status:  :bad_request }
        format.json { render json: @trimester.errors, status: :bad_request }
      end
    end
  end
  def destroy
    @trimester.destroy!

    respond_to do |format|
      format.html { redirect_to trimesters_path, status: :see_other, notice: "Trimester was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trimester
      @trimester = Trimester.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def trimester_params
      params.expect(trimester: [ :year, :term, :application_deadline, :start_date, :end_date ])
    end
  end

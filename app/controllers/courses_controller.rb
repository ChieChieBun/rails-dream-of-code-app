class CoursesController < ApplicationController
  before_action :set_course, only: %i[ show edit update destroy ]
  before_action :require_admin, only: %i[ create edit update destroy ]

  # GET /courses or /courses.json
  def index
    @courses = Course.all
    @user = User.find_by(id: session[:user_id])
  end

  # GET /courses/1 or /courses/1.json
  def show
  @students = @course.students
  @user = User.find_by(id: session[:user_id])
  end

  # GET /courses/new
  def new
    @course = Course.new
    @trimesters = Trimester.all
    @coding_classes = CodingClass.all
  end

  # GET /courses/1/edit
  def edit
    @coding_classes = CodingClass.all
    @trimesters = Trimester.all
  end

  # POST /courses or /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        # Redirect to the course page
        format.html { redirect_to @course, notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        @trimesters = Trimester.all
        @coding_classes = CodingClass.all
        # Re-render the new course form. The view already contains
        # logic to display the errors in @course.errors
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: "Course was successfully updated." }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @course.destroy!

    respond_to do |format|
      format.html { redirect_to courses_path, status: :see_other, notice: "Course was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.expect(course: [ :coding_class_id, :trimester_id, :max_enrollment ])
    end
end

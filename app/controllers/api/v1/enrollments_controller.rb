class Api::V1::EnrollmentsController < ApplicationController

  def index
    #  enrollments_hash = {
    #   enrollments: [
    #     {
    #       id: 2,
    #       first_name: "Levi",
    #       last_name: "Treutel",
    #       final_grade: "completed",
    #     },
    #     {
    #       id: 3,
    #        first_name: "Stormy",
    #       last_name: "Hartmann",
    #       final_grade: "",
    #     }
    #   ]
    # }

    @current_trimester = Trimester.where("start_date <= ?", Date.today).where("end_date >= ?", Date.today).first

    @courses = @current_trimester.courses

    @course = Course.includes(enrollments: :student).find_by(id: params[:course_id])


          enrollments_hash = {
          enrollments: @course.enrollments.map do |enrollment|{
            id: enrollment.id,
            student_id: enrollment.student.id,
            first_name: enrollment.student.first_name,
            last_name: enrollment.student.last_name,
            final_grade: enrollment.final_grade,
            }
            end
          }




    render json: enrollments_hash, status: :ok
  end
end

class Api::V1::CoursesController < ApplicationController

  def index
    # courses_hash = {
    #   courses: [
    #     {
    #       id: 55,
    #       title: "Intro to Programming",
    #       application_deadline: "2025-01-15",
    #       start_date: "2025-01-15",
    #       end_date: "2025-01-15"
    #     },
    #     {
    #       id: 61,
    #       title: "Ruby on Rails",
    #       application_deadline: "2025-01-15",
    #       start_date: "2025-01-15",
    #       end_date: "2025-01-15"
    #     }
    #   ]
    # }

    @current_trimester = Trimester.where("start_date <= ?", Date.today).where("end_date >= ?", Date.today).first

    @courses = @current_trimester.courses

    courses_hash = {
      courses: @courses.map do |course|
        {
          id: course.id,
          title: course.coding_class.title,
          application_deadline: course.trimester.application_deadline ,
          start_date: course.trimester.start_date,
          end_date: course.trimester.end_date
      }
      end
    }

    render json: courses_hash, status: :ok
  end

end

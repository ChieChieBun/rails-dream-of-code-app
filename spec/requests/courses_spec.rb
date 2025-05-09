require 'rails_helper'

RSpec.describe "Courses", type: :request do
  describe 'GET courses_path(:id)' do
    before do
      coding_class = CodingClass.create!(
        title: "Javascript"
      )
      current_trimester = Trimester.create!(
        term: 'Spring',
        year: Date.today.year.to_s,
        start_date: Date.today - 1.day,
        end_date: Date.today + 2.months,
        application_deadline: Date.today - 16.days
      )
      course1 = Course.create!(
        coding_class: coding_class,
        trimester: current_trimester,
        max_enrollment: 25
      )
      (1..2).each do |i|
        Student.create!(
          first_name: "First Name #{i}",
          last_name: "Last Name #{i}",
          email: "email@#{i}.com",
        )
      end
      Enrollment.create!(
        student: Student.first,
        course: course1,
        final_grade: nil,
        created_at: Date.new(2025, 2, 28)
    )
    Enrollment.create!(
        student: Student.last,
        course: course1,
        final_grade: nil,
        created_at: Date.new(2025, 3, 2)
    )


    end


        it "returns the course name and at least one student name" do
          # Check for successful response
          get courses_path(:id)
          expect(response).to have_http_status(:ok)
        end

        it "Shows Course title" do
          get courses_path(:id)
          expect(response.body).to include("Javascript")
      end
      it "shows students names" do
        get courses_path(:id)
          # Check if student names are included in the response
          expect(response.body).to include(Student.first.first_name)
          expect(response.body).to include(Student.last.first_name)
        end
  end
end

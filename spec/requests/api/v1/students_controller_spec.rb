require 'rails_helper'

RSpec.describe "Api::V1::Students", type: :request do
  describe "POST /api/v1/students" do
before do
      # create existing student to test duplicate email validation
      Student.create!(
        first_name: 'John',
        last_name: 'Turner',
        email: 'copy@example.com'
      )
    end

    let(:valid_attributes) do
      {
        student: {
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          email: 'validstudent@example.com'
        }
      }
    end
      let(:nonvalid_attributes) do
      {
        student: {
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          email: ''
        }
      }
    end
    let(:copy_attributes) do
      {
        student: {
          first_name: 'John',
          last_name: 'Turner',
          email: 'copy@example.com'
        }
      }
    end

    it "creates a new student" do
      expect {
        post '/api/v1/students', params: valid_attributes
      }.to change(Student, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['student']['email']).to eq("validstudent@example.com")
    end
    it "doesn't create a new student" do
      expect {
        post '/api/v1/students', params: nonvalid_attributes
      }.to change(Student, :count).by(0)

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "doesn't create a new student" do

      expect {
        post '/api/v1/students', params: copy_attributes
      }.to change(Student, :count).by(0)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end

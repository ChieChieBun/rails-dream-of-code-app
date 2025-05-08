require 'rails_helper'

RSpec.describe "Mentors", type: :request do
  describe "GET /mentors" do
    context 'mentors exist' do
      before do
        (1..2).each do |i|
          Mentor.create!(
            first_name: "First Name #{i}",
            last_name: "Last Name #{i}",
            email: "email@#{i}.com",
            max_concurrent_students: '25',
          )
        end
      end

      it 'returns a page containing names of all mentors' do
        get '/mentors'
        expect(response.body).to include('First Name 1', 'Last Name 1', 'email@1.com')
        expect(response.body).to include('First Name 2', 'Last Name 2', 'email@2.com')
      end
    end
    context 'mentors do not exist' do
      it 'returns a page containing no names of mentors' do
        get '/mentors'
        expect(response.body).not_to include('First Name 1', 'Last Name 1', 'email@1.com')
        expect(response.body).not_to include('First Name 2', 'Last Name 2', 'email@2.com')
      end
    end
  end
end

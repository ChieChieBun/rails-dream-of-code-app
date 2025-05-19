require 'rails_helper'

RSpec.describe "Trimesters", type: :request do
  describe "GET /trimesters" do
    context 'trimesters exist' do
      before do
        (1..2).each do |i|
          Trimester.create!(
            term: "Term#{i}",
            year: '2025',
            start_date: '2025-01-01',
            end_date: '2025-01-01',
            application_deadline: '2025-01-01',
          )
        end
      end

      it 'returns a page containing names of all trimesters' do
        get '/trimesters'
        expect(response.body).to include('Term1 2025')
        expect(response.body).to include('Term2 2025')
      end
    end
    context 'trimesters do not exist' do
      it 'returns a page containing names of all trimesters' do
        get '/trimesters'
        expect(response.body).not_to include('Term1 2025')
        expect(response.body).not_to include('Term2 2025')
      end
    end
     # When a PUT request is made with an application deadline that is a valid date, and a trimester exists for the trimester id included in the request, a trimester's application deadline is updated as expected (per request data)


  end
  describe "PUT /trimesters/id" do
    before do
      @trimester = Trimester.create!(
        term: "Term1",
        year: '2025',
        start_date: '2025-01-01',
        end_date: '2025-01-01',
        application_deadline: '2025-01-01',
      )
    end
    it "Opens trimester then edit" do
      put trimester_path(@trimester), :params => {:trimester => {
        :term => "Term5",
        :year => "2029",
        :application_deadline => "2029-02-02",
      }}
      get trimester_path(@trimester)
      expect(response.body).to include('Term5')
      expect(response.body).to include('2029-02-02')
    end
    it "fails because no deadline" do
      put trimester_path(@trimester), :params => {:trimester => {
        :term => "Term6",
        :year => "2030",
        :start_date => "2025-01-01",
        :end_date => "2025-01-01",
        :application_deadline => "",
      }}
      expect(response).to have_http_status(:bad_request)
    end
    it "fails because not a valid date" do
      put trimester_path(@trimester), :params => {:trimester => {
        :term => "Term6",
        :year => "2030",
        :start_date => "2025-01-01",
        :end_date => "2025-01-01",
        :application_deadline => "2034-04-42",
      }}
      expect(response).to have_http_status(:bad_request)
    end
    it "fails because trimester doesn't exist" do
      put trimester_path(5), :params => {:trimester => {
        :term => "Term6",
        :year => "2030",
        :start_date => "2025-01-01",
        :end_date => "2025-01-01",
        :application_deadline => "2034-04-23",
      }}
      expect(response).to have_http_status(:not_found)
    end

  end

  # When a PUT request is made without an application deadline, the test expects the response status to be 400 (or :bad_request).
  # When a PUT request is made and the application deadline is not a valid date, the test expects the response status to be 400 (or :bad_request).
  # When a PUT request is made to a route with a trimester id that does not belong to an existing trimester, the test expects the response status to be 404 (or :not_found)
end

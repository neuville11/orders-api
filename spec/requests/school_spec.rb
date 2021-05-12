require "rails_helper"
require "byebug"

RSpec.describe "schools", type: :request do

  describe "POST /schools [Create]" do

    it "should create a school" do
      req_payload = {
        school: {
          name: "Thomas Jefferson",
          address: "1st Av downtown"
        }
      }
      # POST HTTP
      post "/api/v1/schools", params: req_payload
      payload = JSON.parse(response.body)
      byebug
      expect(payload).to_not be_empty
      expect(payload["id"]).to_not be_nil
      expect(response).to have_http_status(:created)
    end

    it "should return error message on invalid school" do
      req_payload = {
        school: {
          name: "Thomas Jefferson"
        }
      }
      # POST HTTP
      post "/api/v1/schools", params: req_payload
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload["error"]).to_not be_empty
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PUT /schools/{id} [Update]" do
    let!(:school) { create(:school) }

    it "should update a school" do
      req_payload = {
        school: {
          name: "Thomas A. Edison",
          address: "1st Av downtown"
        }
      }

      put "/api/v1/schools/#{school.id}", params: req_payload
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload["id"]).to eq(school.id)
      expect(response).to have_http_status(:ok)
    end

    it "should return error message on invalid school" do
      req_payload = {
        school: {
          name: nil,
          address: nil
        }
      }
      put "/api/v1/schools/#{school.id}", params: req_payload
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload["error"]).to_not be_empty
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end

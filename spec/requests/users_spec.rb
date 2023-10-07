require 'rails_helper'

RSpec.describe "/users" do
  let(:valid_attributes) do
    attributes_for(:user)
  end

  let(:invalid_attributes) do
    { name: nil }
  end

  let(:valid_headers) do
    {}
  end

  # curl -H 'Content-Type: application/json' 'http://localhost:3000/users'
  describe "GET /index" do
    it "renders a successful response" do
      User.create! valid_attributes
      get users_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      user = User.create! valid_attributes
      get user_url(user), as: :json
      expect(response).to be_successful
    end
  end

  # curl -X POST -H 'Content-Type: application/json' -d '{"name":"James Bond","email":"007@mail.ru"}' 'http://localhost:3000/users'
  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new User" do
        expect do
          post users_url,
               params: { user: valid_attributes }, headers: valid_headers, as: :json
        end.to change(User, :count).by(1)
      end

      it "renders a JSON response with the new user" do
        post users_url,
             params: { user: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new User" do
        expect do
          post users_url,
               params: { user: invalid_attributes }, as: :json
        end.not_to change(User, :count)
      end

      it "renders a JSON response with errors for the new user" do
        post users_url,
             params: { user: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end
end

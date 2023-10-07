require 'rails_helper'

RSpec.describe "/users" do
  let(:user) do
    create(:user)
  end

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
    subject(:get_users_request) do
      get users_url, headers: valid_headers, as: :json
    end

    before do
      # create user
      user
    end

    it "renders a successful response" do
      get_users_request
      expect(response).to be_successful
    end

    it "renders a JSON response with the user name" do
      get_users_request
      expect(response.parsed_body.first['name']).to eq(user.name)
    end

    it "renders a JSON response with the user email" do
      get_users_request
      expect(response.parsed_body.first['email']).to eq(user.email)
    end
  end

  describe "GET /show" do
    subject(:get_user_request) do
      get user_url(user), as: :json
    end

    it "renders a successful response" do
      get_user_request
      expect(response).to be_successful
    end

    it "renders a JSON response with the user name" do
      get_user_request
      expect(response.parsed_body['name']).to eq(user.name)
    end

    it "renders a JSON response with the user email" do
      get_user_request
      expect(response.parsed_body['email']).to eq(user.email)
    end
  end

  # curl -X POST -H 'Content-Type: application/json' -d '{"name":"James Bond","email":"007@mail.ru"}' 'http://localhost:3000/users'
  describe "POST /create" do
    context "with valid parameters" do
      subject(:create_user_request) do
        post users_url,
             params: { user: valid_attributes },
             headers: valid_headers,
             as: :json
      end

      it "creates a new User" do
        expect { create_user_request }.to change(User, :count).by(1)
      end

      it "returns 201 Created HTTP Status" do
        create_user_request
        expect(response).to have_http_status(:created)
      end

      it "renders a JSON response with the new user name" do
        create_user_request
        expect(response.parsed_body['name']).to eq(User.last.name)
      end

      it "renders a JSON response with the new user email" do
        create_user_request
        expect(response.parsed_body['email']).to eq(User.last.email)
      end
    end

    context "with invalid parameters" do
      subject(:post_request_with_invalid_params) do
        post users_url, params: { user: invalid_attributes }, as: :json
      end

      it "does not create a new User" do
        expect { post_request_with_invalid_params }.not_to change(User, :count)
      end

      it 'returns 422 Unprocessable Content HTTP Status' do
        post_request_with_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "renders a JSON response with errors for the new user" do
        post_request_with_invalid_params
        expect(response.parsed_body["name"]).to include("can't be blank")
      end
    end
  end
end

require 'rails_helper'
RSpec.describe "/characters", type: :request do
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # CharactersController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Character.create! valid_attributes
      get characters_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      character = Character.create! valid_attributes
      get character_url(character), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Character" do
        expect {
          post characters_url,
               params: { character: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Character, :count).by(1)
      end

      it "renders a JSON response with the new character" do
        post characters_url,
             params: { character: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Character" do
        expect {
          post characters_url,
               params: { character: invalid_attributes }, as: :json
        }.to change(Character, :count).by(0)
      end

      it "renders a JSON response with errors for the new character" do
        post characters_url,
             params: { character: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested character" do
        character = Character.create! valid_attributes
        patch character_url(character),
              params: { character: new_attributes }, headers: valid_headers, as: :json
        character.reload
        skip("Add assertions for updated state")
      end

      it "renders a JSON response with the character" do
        character = Character.create! valid_attributes
        patch character_url(character),
              params: { character: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the character" do
        character = Character.create! valid_attributes
        patch character_url(character),
              params: { character: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested character" do
      character = Character.create! valid_attributes
      expect {
        delete character_url(character), headers: valid_headers, as: :json
      }.to change(Character, :count).by(-1)
    end
  end
end
require 'rails_helper'

RSpec.describe "/api/studios", type: :request do
  describe "GET /api/studios" do
    subject(:get_studios) { get '/api/studios' }
    context 'when there are no studios in the DB' do
      before(:each) { get_studios }
      it 'returns a HTTP STATUS 200' do
        expect(response).to have_http_status(:ok)
      end
      it 'returns an empty list' do
        expect(json_response[:studios]).to eq([])
      end
    end

    context 'when there are one or more studios in the DB' do
      before(:all) { create_list(:studio, 5) }
      before(:each) { get_studios }
      it 'returns an array of 5 Studios' do
        expect(json_response[:studios].length).to eq(5)
      end

      it 'checks for each studio to have keys name and image' do
        json_response[:studios].each do |studio|
          expect(studio).to have_key(:name)
          expect(studio).to have_key(:image)
        end
      end

      it 'returns HTTP STATUS 200' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "GET /api/studios/studio_id" do
    subject(:get_studio) { get "/api/studios/#{id}" }
    context 'when the id belongs to a studio en the DB' do

      before(:all) do
        create_list(:studio, 2)
        create_list(:show, 2, studio_id:Studio.first.id)
        create_list(:movie, 2, studio_id:Studio.first.id)

        create_list(:show, 2, studio_id:Studio.last.id)
        create_list(:movie, 2, studio_id:Studio.last.id)
      end

      let(:id) { Studio.first.id }
      before(:each) { get_studio }

      it 'returns a HTTP STATUS 200' do
        expect(response).to have_http_status(:ok)
      end
      it "returns the studio's name, image, movies and shows" do
        expect(json_response[:studio]).to have_key(:name)
        expect(json_response[:studio]).to have_key(:image)
        expect(json_response[:studio]).to have_key(:movies)
        expect(json_response[:studio]).to have_key(:shows)
      end

      it 'returns the movies that belong to the first studio' do
        expect(json_response[:studio][:movies].first[:id]).to eq(Studio.first.movies.first.id)
        expect(json_response[:studio][:movies].last[:id]).to eq(Studio.first.movies.last.id)
      end

      it 'returns the shows that belong to the first studio' do
        expect(json_response[:studio][:shows].first[:id]).to eq(Studio.first.shows.first.id)
        expect(json_response[:studio][:shows].last[:id]).to eq(Studio.first.shows.last.id)
      end

      it "does not return movies that don't belong to the first studio" do
        expect(json_response[:studio][:movies].first[:id]).not_to eq(Studio.last.movies.first.id)
        expect(json_response[:studio][:movies].last[:id]).not_to eq(Studio.last.movies.last.id)
      end

      it "does not return shows that don't belong to the first studio" do
        expect(json_response[:studio][:shows].first[:id]).not_to eq(Studio.last.shows.first.id)
        expect(json_response[:studio][:shows].last[:id]).not_to eq(Studio.last.shows.last.id)
      end
      after(:all) { DatabaseCleaner.clean_with(:truncation) }
    end

    context 'when the id does not belong to a studio in the DB' do
      let(:id) {1}
      before(:each) { get_studio }
      it 'returns a HTTP STATUS 404 not found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns an error message' do
        expect(json_response[:error]).to eq("Couldn't find Studio with 'id'=#{id} not found")
      end
    end
  end

  describe "POST /api/studios" do
    subject(:create_studio) do
      post '/api/studios', headers: { 'access-token' => token, 'uid' => uid, 'client' => client }, params: { studio: attributes }
    end
    let(:attributes) { attributes_for(:studio) }
    context 'when user is not logged in' do
      let(:token) { 1231274}
      let(:uid) { "asdasd@asda.com" }
      let(:client) { "Asdasdaswd" }
      before(:each) { create_studio }

      it 'returns a HTTP STATUS 401' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns an error message' do
        expect(json_response[:errors]).to eq(["You need to sign in or sign up before continuing."])
      end
    end

    context 'when user is logged in' do
      let(:token) { response.headers['access-token'] }
      let(:uid) { response.headers['uid'] }
      let(:client) { response.headers['client'] }
      context 'when user is not an admin' do
        let(:user) { create(:user) }
        before(:each) do
          login_with_api(user)
          @json_response = nil
          create_studio
        end
        it 'returns a HTTP STATUS 401' do
          expect(response).to have_http_status(:unauthorized)
        end
        it 'returns an error mesage' do
          expect(json_response[:error]).to eq("You don't have admin permissions")
        end
      end
      context 'when user is an admin' do
        let(:admin_user) { create(:user, :admin_user) }
        context 'when incorrect params are sent' do
          before(:each) do
            login_with_api(admin_user)
            @json_response = nil
            attributes[:name] =''
            create_studio
          end
          it 'returns a HTTP STATUS 400 bad request' do
            expect(response).to have_http_status(:bad_request)
          end

          it 'returns an error message detailing the incorrect param' do
            expect(json_response[:name]).to eq(["can't be blank"])
          end
        end

        context 'when params are correct' do
          before(:each) do |example|
            login_with_api(admin_user)
            @json_response = nil
            create_studio unless example.metadata[:skip_before]
          end
          it 'returns HTTP STATUS 201' do
            expect(response).to have_http_status(:ok)
          end

          it 'adds one studio to the database', :skip_before do
            expect{ create_studio }.to change(Studio, :count).by(1)
          end

          it 'returns a JSON response with the created studio' do
            expect(json_response[:studio][:id]).to eq(Studio.first.id)
            expect(json_response[:studio][:name]).to eq(Studio.first.name)
          end
        end
      end
    end
  end

  describe "PUT/PATCH /api/studios/studio_id" do
    context 'when user is not logged in' do
      it 'returns a HTTP STATUS 401' do

      end

      it 'returns an error message' do

      end
    end

    context 'when user is logged in' do
      context 'when user is not an admin' do
        it 'returns a HTTP STATUS 401' do

        end
        it 'returns an error mesage' do

        end
      end

      context 'when user is an admin' do
        context 'when the id does not belong to a studio in the DB' do
          it 'returns a HTTP STATUS 404 not found' do

          end
        end

        context 'when the id belongs to a studio in the DB' do
          context 'when incorrect params are sent' do
            it 'returns a HTTP STATUS 422' do

            end

            it 'returns an error message detailing the incorrect param' do

            end
          end

          context 'when correct params are sent' do
            it 'returns a HTTP STATUS 200' do

            end

            it 'updates the studio information' do

            end
          end
        end
      end
    end
  end

  describe "DELETE /api/studios/studio_id" do
    context 'when user is not logged in' do
      it 'returns a HTTP STATUS 401' do

      end

      it 'returns an error message' do

      end
    end

    context 'when user is logged in' do
      context 'when user is not an admin' do
        it 'returns a HTTP STATUS 401' do

        end
        it 'returns an error mesage' do

        end
      end

      context 'when user is an admin' do
        context 'when the id does not belong to a studio in the DB' do
          it 'returns a HTTP STATUS 404 not found' do

          end

          it 'returns an error message' do

          end
        end

        context 'when the id belongs to a studio in the DB' do
          it 'returns a HTTP STATUS 204 (no content)' do

          end

          it 'reduces studios database count by 1' do

          end
        end
      end
    end
  end
end

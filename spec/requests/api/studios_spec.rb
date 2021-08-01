require 'rails_helper'

RSpec.describe "/api/studios", type: :request do
  describe "GET /api/studios" do
    subject(:get_studios) { get '/api/studios' }
    context 'when there are no studios in the DB' do
      before(:all) { get_studios }
      it 'returns a HTTP STATUS 200' do
        expect(json_response).to have_http_status(:ok)
      end
      it 'returns an empty list' do
        expect(json_response[:studios]).to eq([])
      end
    end

    context 'when there are one or more studios in the DB' do
      # Create 5 studios
      it 'returns an array of 5 Studios' do
      end

      it 'checks for each studio to have keys name and image' do
        
      end
      
      it 'returns HTTP STATUS 200' do
        
      end
    end
  end

  describe "GET /api/studios/studio_id" do
    context 'when the id belongs to a studio en the DB' do
      it "returns the studio's name, image, movies and shows" do
        
      end
    end

    context 'when the id does not belong to a studio in the DB' do
      it 'returns a HTTP STATUS 404 not found' do
        
      end

      it 'returns an error message' do
        
      end
    end
  end

  describe "POST /api/studios" do
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
        context 'when incorrect params are sent' do
          it 'returns a HTTP STATUS 422' do
          
          end
          
          it 'returns an error message detailing the incorrect param' do
            
          end
        end

        context 'when params are correct' do
          it 'returns HTTP STATUS 201' do
            
          end

          it 'adds one studio to the database' do
            
          end

          it 'returns a JSON response with the created studio' do
            
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

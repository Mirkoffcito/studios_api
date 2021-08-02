# Command for creating this file rails generate rspec:swagger ../integration/API::StudiosController
# Command for generating the yaml file rails rswag:specs:swaggerize
require 'swagger_helper.rb'
RSpec.describe '../integration/api/studios', type: :request do
  path '/api/studios' do
    get 'Returns all studios' do
      tags 'Studios'
      produces 'application/json'

      response '200', 'Lists all studios' do
        schema type: :object,
          properties: {
            studios: {
              type: :array,
              items: {
                properties: {
                  id: { type: :integer },
                  name: { type: :string },
                  image: { type: :string }
                }
              }
            }
          }

          examples 'application/json' => {
            studios: [
              {
                id: 1,
                name: 'Fox Studios',
                image: 'https://www.imgur.com/fox_studios.jpg'
              },
              {
                id: 2,
                name: 'Marvel Studios',
                image: 'https://www.imgur.com/marvel_studios.jpg'
              }
            ]
          }
        run_test!
      end
    end

    post 'Creates a studio' do
      tags 'Studios'
      consumes 'application/json'
      produces 'application/json'
      security [token:{}, uid:{}, client:{}]

      parameter name: :studio, in: :body, schema: {
        type: :object,
        properties: {
          studio: {
            type: :object,
            properties: {
              name: { type: :string },
              image: { type: :string }
            },
            requires: %w[name]
          }
        }
      }

      response '201', 'Studio Created' do
        examples 'application/json' => {
          studio: {
            name: 'Fox Studios',
            image: 'Image file'
          }
        }

        run_test!
      end

      response '401', 'unauthorized access(user not logged in)' do
        run_test!
      end

      response ' 401', 'unauthorized access(user is not an admin)' do
        run_test!
      end

      response '400', 'bad request' do
        run_test!
      end
    end
  end

  path '/api/studios/{id}' do
    get 'Returns a specific studio' do
      tags 'Studios'
      produces 'application/json'

      parameter name: :id, in: :path, type: :string

      response '200', 'renders specific studio' do
        examples 'application/json' => {
          studio: {
            id: 1,
            name: 'Fox Studios',
            image: 'https://www.imgur.com/fox_studios.jpg',
            movies: [
              {
                id: 1,
                title: 'Los simpsons',
                release_date: '1997-04-02',
                image: 'https://www.imgur.com/simpsons.jpg'
              }
            ],
            shows: [
              {
                id: 4,
                title: 'Los simpsons',
                release_date: '1997-04-02',
                seasons: 15,
                image: 'https://www.imgur.com/simpsons.jpg'
              }
            ]
          }
        }
        run_test!
      end

      response '404', 'studio not found' do
        run_test!
      end
    end

    patch 'Updates a specific studio' do
      tags 'Studios'
      consumes 'application/json'
      produces 'application/json'
      security [token:{}, uid:{}, client:{}]

      parameter name: :id, in: :path, type: :string

      parameter name: :studio, in: :body, schema: {
        type: :object,
        properties: {
          studio: {
            type: :object,
            properties: {
              name: { type: :string },
              image: { type: :string }
            }
          }
        }
      }

      response '200', 'Succesfully updated the studio' do
        examples 'application/json' => {
          studio: {
            name: 'Fox Studios',
            image: 'Image file'
          }
        }
        run_test!
      end

      response '404', 'Studio not found' do
        run_test!
      end

      response '400', 'Invalid params sent' do
        run_test!
      end

      response '401', 'Unauthorized access(User not logged in)' do
        run_test!
      end

      response ' 401', 'Unauthorized access(User not an admin)' do
        run_test!
      end
    end

    delete 'Deletes a specific studio' do
      tags 'Studios'
      produces 'application/json'
      security [token:{}, uid:{}, client:{}]
  
      parameter name: :id, in: :path, type: :string
  
      response '404', 'Not found(Studio not found)' do
        run_test!
      end
  
      response '204', 'No content(succesfully deleted)' do
        run_test!
      end
  
      response '401', 'Unauthorized access(User not logged in)' do
        run_test!
      end
  
      response ' 401', 'Unauthorized access(User not an admin)' do
        run_test!
      end
    end
  end
end

# Command for creating this file rails generate rspec:swagger ../integration/API::StudiosController
# Command for generating the yaml file rails rswag:specs:swaggerize
require 'swagger_helper.rb'
RSpec.describe '../integration/api/studios', type: :request do
  path '/api/studios' do
    get 'Returns all studios' do
      tags 'Studios'
      produces 'application/json'

      response '200', 'lists studios' do
        run_test!
      end
    end

    post 'Creates a studio' do
      tags 'Studios'
      consumes 'application/json'
      produces 'application/json'
      security [token:{}, uid:{}, client:{}]

      response '201', 'Studio Created' do
        
      end

      response '401', 'unauthorized access' do
        
      end

      response '400'. 'bad request' do
        
      end
    end
  end
end

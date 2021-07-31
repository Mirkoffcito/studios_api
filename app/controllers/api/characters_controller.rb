module Api
  class CharactersController < ApplicationController
    before_action :authenticate_api_user!, only: [:create, :update, :destroy]
    # GET /characters
    def index
      @characters = Character.all

      render json: @characters, each_serializer: CharactersSerializer
    end

    # GET /characters/1
    def show
      render json: character, serializer: CharacterSerializer
    end

    # POST /characters
    def create
      @character = Character.new(character_params)

      if @character.save
        render json: @character, status: :created, serializer: CharacterSerializer
      else
        render json: @character.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /characters/1
    def update
      if character.update(character_params)
        render json: @character
      else
        render json: character.errors, status: :unprocessable_entity
      end
    end

    # DELETE /characters/1
    def destroy
      character.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def character
        @character ||= Character.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def character_params
        params.require(:character).permit(:name, :age, :history, :weight, :id)
      end
  end
end

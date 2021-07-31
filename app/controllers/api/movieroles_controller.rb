module Api
  class MovierolesController < ApplicationController
    before_action :authenticate_api_user!, only: [:create, :destroy]
    before_action :authorize_request, only: [:create, :destroy]

    #/api/studios/1/movies/1/characters?by_name=Spider man
    has_scope :by_name
    
    def create
      if find_character_from_param.nil?
        @role = MovieRole.new(character_id:character.id, movie_id:movie.id)

        if @role.save
          render json: @movie, serializer: MovieSerializer
        else
          render json: @role.errors, status: :bad_request
        end
      else
        render json: {error: "Character already exists in this movie"}, status: :bad_request
      end
    end

    def index_characters
      render json: apply_scopes(movie.characters), each_serializer: CharactersSerializer
    end

    def show_character
      if find_character_from_path.nil?
        render json: { error: "Character not found" }, status: :not_found
      else
        render json: find_character_from_path, serializer: CharacterSerializer
      end
    end

    def destroy
      movierole.destroy
    end

    private
    
    def movierole
      @role ||= MovieRole.find_by(movie_id:movie.id, character_id:(params[:character_id]))
    end

    def find_character_from_path
      @char ||= movie.characters.find_by(id: params[:character_id])
    end

    def find_character_from_param
      @char ||= movie.characters.find_by(id: character.id)
    end

    def character
      @character ||= Character.find(params[:character][:id])
    end

    def movie
      @movie ||= studio.movies.find(params[:movie_id])
    end

    def studio
      @studio ||= Studio.find(params[:studio_id])
    end
  end
end
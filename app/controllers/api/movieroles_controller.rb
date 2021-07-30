module Api
  class MovierolesController < ApplicationController

    def create
      if find_character.nil?
        @role = MovieRole.new(character_id:character.id, movie_id:movie.id)

        if @role.save
          render json: @movie, serializer: MovieSerializer
        else
          render json: character.errors, status: :bad_request
        end
      else
        render json: {error: "Character already exists in this movie"}, status: :bad_request
      end
    end

    def destroy
      movierole.destroy
    end

    private
    def movierole
      @role ||= MovieRole.find_by(movie_id:movie.id, character_id:(params[:character_id]))
    end

    def find_character
      movie.characters.find_by(id: character.id)
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
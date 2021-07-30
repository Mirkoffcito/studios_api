module Api
  class ShowrolesController < ApplicationController
    
    def create
      if find_character.nil?
        @role = ShowRole.new(character_id:character.id, show_id:tvshow.id)

        if @role.save
          render json: @show, serializer: ShowSerializer
        else
          render json: character.errors, status: :bad_request
        end
      else
        render json: {error: "Character already exists in this show"}, status: :bad_request
      end
    end

    def destroy
      showrole.destroy
    end

    private
    def showrole
      @role ||= ShowRole.find_by(show_id:tvshow.id, character_id:(params[:character_id]))
    end

    def find_character
      tvshow.characters.find_by(id: character.id)
    end

    def character
      @character ||= Character.find(params[:character][:id])
    end

    def tvshow
      @show ||= studio.shows.find(params[:show_id])
    end

    def studio
      @studio ||= Studio.find(params[:studio_id])
    end
  end
end

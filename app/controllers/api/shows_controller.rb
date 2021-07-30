module Api
  class ShowsController < ApplicationController

    # GET /shows
    def index
      @shows = studio.shows.includes(:studio)

      render json: @shows, each_serializer: ShowsSerializer
    end

    # GET /shows/1
    def show
      render json: tvshow, serializer: ShowSerializer
    end

    # POST /shows
    def create
      @show = Show.new(show_params)
      @show.studio_id = studio.id

      if @show.save
        render json: @show, status: :created, serializer: ShowSerializer
      else
        render json: @show.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /shows/1
    def update
      if tvshow.update(show_params)
        render json: @show, serializer: ShowSerializer
      else
        render json: @show.errors, status: :bad_request
      end
    end

    # DELETE /shows/1
    def destroy
      tvshow.destroy
    end

    private
      def studio
        @studio ||= Studio.find(params[:studio_id])
      end
      # Use callbacks to share common setup or constraints between actions.
      def tvshow
        @show ||= studio.shows.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def show_params
        params.require(:show).permit(:title, :seasons, :score, :release_date)
      end

      def record_not_found
        if @studio.nil?
          render json: { error: "studio not found" }, status: :not_found
        else
          render json: { error: "#{controller_name.singularize} not found" }, status: :not_found
        end
      end
  end
end

module Api
  class ShowsController < ApplicationController
    before_action :authenticate_api_user!, only: [:create, :update, :destroy]
    before_action :authorize_request, only: [:create, :update, :destroy]

    # /shows?by_title=Iron man
    has_scope :by_title
    # /shows?by_releasedate[from]=1997-04-02&by_releasedate[to]=2005-04-02
    has_scope :by_releasedate, using: %i[from to], type: :hash
    # /shows?by_seasons=3 (number of seasons)
    has_scope :by_seasons

    # GET /shows
    def index
      @shows = apply_scopes(studio.shows.includes(:studio))

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
        params.require(:show).permit(:title, :seasons, :score, :release_date, :image)
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

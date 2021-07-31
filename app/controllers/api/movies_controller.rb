module Api
  class MoviesController < ApplicationController
    before_action :authenticate_api_user!, only: [:create, :update, :destroy]
    before_action :authorize_request, only: [:create, :update, :destroy]

    # /movies?by_title=Iron man
    has_scope :by_title
    # /movies?by_releasedate[from]=1997-04-02&by_releasedate[to]=2005-04-02
    has_scope :by_releasedate, using: %i[from to], type: :hash

    # GET /movies
    def index
      @movies = apply_scopes(studio.movies.includes(:studio))

      paginate @movies, per_page: 5, each_serializer: MoviesSerializer
    end

    # GET /movies/1
    def show
      render json: movie, serializer: MovieSerializer
    end

    # POST /movies
    def create
      @movie = Movie.new(movie_params)
      @movie.studio_id = studio.id

      if @movie.save
        render json: @movie, status: :created, serializer: MovieSerializer
      else
        render json: @movie.errors, status: :bad_request
      end
    end

    # PATCH/PUT /movies/1
    def update
      if movie.update(movie_params)
        render json: @movie, serializer: MovieSerializer
      else
        render json: @movie.errors, status: :unprocessable_entity
      end
    end

    # DELETE /movies/1
    def destroy
      movie.destroy
    end

    private
      def studio
        @studio ||= Studio.find(params[:studio_id])
      end

      def movie
        @movie ||= studio.movies.find(params[:id])
      end

      def movie_params
        params.require(:movie).permit(:title, :release_date, :score, :image)
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

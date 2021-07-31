module Api
  class StudiosController < ApplicationController
    before_action :authenticate_api_user!, only: [:create, :update, :destroy]
    before_action :authorize_request, only: [:create, :update, :destroy]
    
    has_scope :by_name
    # GET /studios
    def index
      @studios = apply_scopes(Studio).all

      render json: @studios, each_serializer: StudiosSerializer
    end

    # GET /studios/1
    def show
      render json: studio, serializer: StudioSerializer
    end

    # POST /studios
    def create
      @studio = Studio.new(studio_params)

      if @studio.save
        render json: @studio, serializer: StudioSerializer
      else
        render json: @studio.errors, status: :bad_request
      end
    end

    # PATCH/PUT /studios/1
    def update
      if studio.update(studio_params)
        render json: @studio, serializer: StudioSerializer
      else
        render json: @studio.errors, status: :bad_request
      end
    end

    # DELETE /studios/1
    def destroy
      studio.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def studio
        @studio ||= Studio.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def studio_params
        params.require(:studio).permit(:name, :image)
      end
  end
end

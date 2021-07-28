class StudiosController < ApplicationController

  # GET /studios
  def index

  end

  # GET /studios/1
  def show
  end

  # POST /studios
  def create

  end

  # PATCH/PUT /studios/1
  def update

  end

  # DELETE /studios/1
  def destroy

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def studio
      @studio ||= Studio.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def studio_params
      params.require(:studio).permit(:name)
    end
end

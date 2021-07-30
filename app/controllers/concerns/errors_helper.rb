module ErrorsHelper
  extend ActiveSupport::Concern
  included do
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActionController::ParameterMissing, with: :parameter_missing

    def record_not_found(subject=nil)
      if subject.nil?
        render json: { error: "#{controller_name.singularize} not found" }, status: :not_found
      else
        render json: { error: "#{subject} not found" }, status: :not_found
      end
    end

    def parameter_missing
      render json: {error: "Parameter is missing or it's value is empty"}
    end
  end
end
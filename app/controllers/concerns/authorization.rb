module Authorization
    def authorize_request
        render json: { error: "You don't have admin permissions" }, status: :unauthorized unless @current_api_user.admin?
    end
end
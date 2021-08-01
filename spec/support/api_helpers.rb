module Request
  module ApiHelpers
    def login_with_api(user)
      post '/api/auth/sign_in', params: {
        email: user.email,
        password: user.password
      }
    end 
  end
end
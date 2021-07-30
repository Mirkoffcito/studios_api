Rails.application.routes.draw do
  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth'
    resources :studios do
      resources :movies
      resources :shows
    end
    resources :characters

    # Movies
    post 'studios/:studio_id/movies/:movie_id/characters', to: 'movieroles#create'
    get 'studios/:studio_id/movies/:movie_id/characters', to: 'movieroles#index_characters'
    get 'studios/:studio_id/movies/:movie_id/characters/:character_id', to: 'characters#show'
    delete 'studios/:studio_id/movies/:movie_id/characters/:character_id', to: 'movieroles#destroy'

    # Shows
    post 'studios/:studio_id/shows/:show_id/characters', to: 'showroles#create'
    get 'studios/:studio_id/shows/:show_id/characters', to: 'showroles#index_characters'
    get 'studios/:studio_id/shows/:show_id/characters/:character_id', to: 'showroles#show_character'
    delete 'studios/:studio_id/shows/:show_id/characters/:character_id', to: 'showroles#destroy'


  end
end

TweetPeek::Application.routes.draw do

  # devise_for :user do
  #   match '/user/sign_in/twitter' => Devise::Twitter::Rack::Signin
  #   match '/user/connect/twitter' => Devise::Twitter::Rack::Connect
  # end

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  #devise_for :users

  root to: 'welcome#index', as: 'user_root'
  get '/twitter/search' => 'search#results', as: 'search_results'
  get '/twitter/top_ten' => 'search#top_ten', as: 'top_ten'
  post '/twitter/search/:twitter_handle/save' => 'user#save', as: 'save_search'
  post '/twitter/search/:twitter_handle/delete' => 'user#delete', as: 'delete_search'
  get '/twitter/favorites' => 'user#favorites', as: 'favorites'
  get '/about' => 'about#about', as: 'about'

end

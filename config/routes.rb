Rails.application.routes.draw do
  get "/signup" => "users#new"
  # post "/users" => "users#create"

  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  delete "/logout" => "sessions#destroy"

  get '/' => 'client/posts#index'

  namespace :client do
    get '/posts' => 'posts#index'
    get '/posts/new' => 'posts#new'
    post '/posts' => 'posts#create'
    get '/posts/:id' => 'posts#show'
    get '/posts/:id/edit' => 'posts#edit'
    patch '/posts/:id' => 'posts#update'
    delete '/posts/:id' => 'posts#destroy'
  end

    get '/users' => 'users#index'
    get '/users/new' => 'users#new'
    post '/users' => 'users#create'
    get '/users/:id' => 'users#show'
    get '/users/:id/edit' => 'users#edit'
    patch '/users/:id' => 'users#update'
    delete '/users/:id' => 'users#destroy'

  namespace :client do
    post '/votes' => 'votes#create'
    delete '/votes/:id' => 'votes#destroy' #passing in post id instead, did not want to break restful routing convention
    # get '/users/:id/edit' => 'users#edit'
    patch '/votes/:id' => 'users#update'

  end

  namespace :client do
    post '/visits' => 'visits#create'
    delete '/visits/:id' => 'visits#destroy' #passing in user id, doing nothing with it, just don't want to break restful conventions
  end

end

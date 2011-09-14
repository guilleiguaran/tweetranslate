Tweetranslate::Application.routes.draw do
  resources :users
  root :to => 'users#new'
  match "/auth/:provider/callback" => "sessions#create"
  match "/logout" => "sessions#destroy"
end

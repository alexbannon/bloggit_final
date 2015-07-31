Rails.application.routes.draw do
  root to: "posts#all_posts"
  get "sign_in" => "users#sign_in_page"
  post "sign_in" => "users#sign_in"
  get "sign_out" => "users#sign_out"
  get ":username" => "users#username_home"
  resources :users do
    resources :posts do
      resources :comments
    end
  end
end

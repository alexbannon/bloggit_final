Rails.application.routes.draw do
  root to: "posts#index"
  get "sign_in" => "users#sign_in_page"
  post "sign_in" => "users#sign_in"
  get "sign_out" => "users#sign_out"
  resources :users do
    resources :posts do
      resources :comments
    end
  end
end

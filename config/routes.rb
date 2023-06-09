Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"

  devise_for :users, controllers: { sessions: "users/sessions" }

  post :url_shortener, to: "link_shortener#url_shortener"
  get '/:alias' , to: "link_shortener#redirect_to_og_url"
end

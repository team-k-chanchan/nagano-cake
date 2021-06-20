Rails.application.routes.draw do

  root to: "customer/homes#top"
  get "/about" => "customer/homes#about"
  
  namespace :customer do
      resources :items, only:[:index, :show]
  end
  
end

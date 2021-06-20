Rails.application.routes.draw do
  namespace :customer do
    get 'homes/top'
    get 'homes/about'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  namespace :customer do
      resources :items, only:[:index, :show]
  end
  
end

Rails.application.routes.draw do
  namespace :customer do
    get 'homes/top'
    get 'homes/about'
  end

  namespace :admin do
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
  end
end

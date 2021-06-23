Rails.application.routes.draw do

  devise_for :admins, path: 'admin', controllers: {
    sessions:      'admin/sessions',
    passwords:     'admin/passwords',
    registrations: 'admin/registrations'
  }
  devise_for :customers, path: 'customer', controllers: {
    sessions:      'customer/sessions',
    passwords:     'customer/passwords',
    registrations: 'customer/registrations'
  }

  root to: "customer/homes#top"
  get "/about" => "customer/homes#about"

  namespace :customer do
    resources :items, only:[:index, :show]
    resources :cart_items, only: [:index, :create, :update, :destroy ] do
      collection do
        delete 'destroy_all'
      end
    end

    resources :items, only: [:index, :show]
    
    resource :customers, only: [:show, :edit, :update] do
  		collection do
  	     get "quit"
  	     patch "out"
  	  end
  	end
  end

  namespace :admin do
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
  end

end

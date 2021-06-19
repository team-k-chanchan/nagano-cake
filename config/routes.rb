Rails.application.routes.draw do
  namespace :customer do
  end

  root to: "customer/homes#top"
  get "/about" => "customer/homes#about"

end

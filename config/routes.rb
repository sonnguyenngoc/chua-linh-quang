Rails.application.routes.draw do
  root "home#index"
  
  namespace :admin, path: "shopme-admin" do
    get "main" => "main#index"
  end
end

Rails.application.routes.draw do
  resources :albums do
    member do
      patch :publish
    end

    resources :tracks
  end
  
  root "albums#index"
end

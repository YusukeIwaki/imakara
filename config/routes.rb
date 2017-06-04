Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :trackings, only: [:show, :create, :destroy] do
    member do
      get 'location', defaults: { format: :png }
    end
    scope module: :trackings do
      resource :observe, only: [:create, :destroy]
      resources :location_logs, only: [:create]
    end
  end
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :trackings, only: [:show, :create] do
    scope module: :trackings do
      resource :observe, only: [:create, :destroy]
    end
  end
end

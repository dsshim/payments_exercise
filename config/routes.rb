Rails.application.routes.draw do
  resources :loans, only: [:index, :show, :create], defaults: {format: :json}
  resources :payments, only: [:create, :show], defaults: {format: :json}

  resources :loans, only: [] do
    resources :payments, only: [:index], defaults: {format: :json}
  end
end

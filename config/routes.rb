Rails.application.routes.draw do
  root to: 'orders#index'
  resources :orders do
    collection do
      get :add_line_item
    end
    member do
      patch :update_settings
      patch :ship
    end
    resources :line_items, only: [:destroy]
  end
end

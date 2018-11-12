Rails.application.routes.draw do
  resources :orders do
    collection do
      get :add_line_item
    end
  end
end

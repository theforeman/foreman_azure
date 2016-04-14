Rails.application.routes.draw do
  resources :hosts do
    collection do
      get 'image_selected'
    end
  end
end

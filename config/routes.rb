Rails.application.routes.draw do
  resources :hosts do
    collection do
      post 'image_selected'
    end
  end
end

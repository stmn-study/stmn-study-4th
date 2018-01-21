Rails.application.routes.draw do
  root 'articles#index'
  resources :articles do
    collection do
      post :upload
    end
  end
end

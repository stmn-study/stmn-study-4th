Rails.application.routes.draw do
  root 'articles#index'
  resources :articles do
    collection do
      post :blob
    end
  end
end

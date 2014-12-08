OpenSuperlist::Application.routes.draw do

  devise_for :users
  
  resources :todos, only: [:index] do
    collection do
      delete 'destroy_multiple'
    end
  end


  namespace :api do
    resources :users, :except => [:index] do
      resources :todos do
        collection do
          delete 'destroy_multiple'
        end
      end
    end

    resources :sessions, :only => [:create, :destroy]
  end


  get 'about' => 'welcome#about'

  root to: 'welcome#index'

end

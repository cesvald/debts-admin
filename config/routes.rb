Rails.application.routes.draw do
  devise_for :users
  get 'home/index'

  resources :users do
    collection do
      get 'detail_concept_payments'
    end
    member do
      get 'detail_debts'
      get 'debts'
    end
  end
  
  resources :agreement_payments do
    member do
      get 'close'
      get 'cancel'
    end
    resources :debts
    resources :payments
  end
  
  resources :general_debts do
    resources :debts
    resources :payments
    resources :agreement_payments do
      resources :debts
      resources :payments
    end
  end
  
  resources :monthly_debts do
    resources :payments
    resources :agreement_payments do
      resources :debts
      resources :payments
    end
  end
  
  root 'users#index'
  
  resources :items do
    collection do
      post 'import'
      get 'import_new'
    end
  end
  
  resources :debts do
    collection do
      post 'import'
      get 'import_new'
     end
  end
  
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end

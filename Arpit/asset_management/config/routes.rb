Rails.application.routes.draw do

  resources :invoices do
    collection do
      get 'get_purchase_order'
    end
  end
  get 'download'=> "welcome#download_file",as: :download

  resources :purchase_orders

  resources :transfers do
    member do
      get 'resources'
    end
  end

  resources :quotations do
    member do
      get 'request_vendors'
      get 'get_requests'
    end
  end

  resources :device_requests
  resources :device_assignments
  resources :device_categories

  resources :devices do
    collection do
      get 'assignment'
      post 'check_serial_uniqueness'
      post 'assignment'
      put 'update_assignment'
    end
    member do
      delete 'destroy_assignment'
    end
  end

  namespace :admin do
    resources :users
  end
  resources :clients
  resources :branches do
    member do
      get 'get_employees'
	  get 'associate_data'
    end
  end
  resources :vendors
  resources :software_products
  resources :employees
  get 'welcome/index'  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }



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

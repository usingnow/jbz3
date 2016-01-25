Rails.application.routes.draw do
  devise_for :users, controllers: { 
    registrations: 'users/registrations',
    sessions: 'users/sessions'
   }

  namespace :wechat do
    get 'board/index'
    get 'board/cover'
    get 'board/legal_announcement'
    
    get 'user_center' => 'users#user_center'
    get 'user_order' => 'users#user_order'
    
    # 第一次上线先暂停短信验证登录，研究 devise 和 javascript 后再启用
    # get 'users/login_by_sms'             

    resources :jbz_skus, only: [:show]

    resources :carts
    resources :line_items, only: [:create] do
      member do
        post :redeem
      end
    end

    resources :orders do
      member do
        get :query_points_for
        get :adjust_points_for
      end
    end

    # resources :query_points
    resources :adjust_points
    # resources :request_dynamic_passwords
    resources :users do
      member do
        get :user_center_of
      end
    end
  end

    # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'wechat/board#index'

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

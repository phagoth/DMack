Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  put   'productions/:production_id/update_director'   =>  'productions#update_director',    as: :update_production_director

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

  resources :invitations

  resources :resumes do
    resources :roles
  end
  get    '/resumes/:id/edit/:role_id'  => 'resumes#edit_with_role', :as => 'edit_resume_with_role'
  post   '/resumes/:id/add_table'      => 'resumes#add_table',      :as => 'add_resume_table'
  delete '/resumes/:id/destroy_table/:table_id'  => 'resumes#destroy_table',  :as => 'destroy_resume_table'

  devise_for :users
  get 'users' => 'users#index', :as => 'users'

  resources :shows

  resources :productions do
    resources :shows
    resources :roles
    resources :director_invitations
    resources :artist_invitations
  end

  resources :rtables do
    resources :rtable_items
  end

  resources :education_tables do
    resources :rtable_items
  end

  resources :companies do
    resources :artist_invitations
  end

  resources :venues do
    resources :artist_invitations
  end
  post 'section_slots' => 'section_slots#sort', :as => 'sort_section_slots'


end

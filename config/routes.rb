Rails.application.routes.draw do

  get 'responses/new'
  post 'responses' => 'responses#create'
  get 'responses' => 'responses#index'

  namespace :admin do
    get 'main/index'
    resources :quest_items, :price_presets, :picturesofwinners
    get 'manage_tickets/price'
    post 'manage_tickets/price_update'
    delete 'responses/:id' => 'responses#destroy', as: 'response'
  end

  post 'sms/send'

  get 'sms/status_upd'

  get 'personal_page' => 'users#personal_page', as: 'personal_page'

  get 'session/logout' => 'session#logout', as: 'logout'

  #   браузер     контроллер       ссыль рельсов
  get 'payment' => 'robokassa#prepay', as: 'payment'

  get 'signin' => 'users#signin', as: 'signin'
  post 'users' => 'users#create'
  post 'user_upd' => 'users#update'
  post 'password_reset' => 'users#password_reset'
  post 'session' => 'session#signin'

  post 'ticket/reserve' => 'tickets#reserve'

  post 'paid_confirmed' => 'robokassa#paid_confirmed'
  get 'transaction_confirmed' => 'robokassa#transaction_confirmed'
  post 'abort_mission' => 'robokassa#abort_mission'

  get 'main/index'

  # get 'tickets/:dt0/price_mass_update(.:format)'
  # get 'tickets/:id/price_mass_update' => 'tickets#price_mass_update'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'main#index'

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



=begin
    quest_items                     GET    /quest_items(.:format)            quest_items#index
                                  POST   /quest_items(.:format)            quest_items#create
    new_quest_item                  GET    /quest_items/signin(.:format)        quest_items#signin
    edit_quest_item                 GET    /quest_items/:id/edit(.:format)   quest_items#edit
    quest_item                      GET    /quest_items/:id(.:format)        quest_items#show
    PATCH  /quest_items/:id(.:format)        quest_items#update
    PUT    /quest_items/:id(.:format)        quest_items#update
    DELETE /quest_items/:id(.:format)        quest_items#destroy
=end

end

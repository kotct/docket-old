Docket::Application.routes.draw do
	get "configuration/show"
	get "configuration/edit"
	get "configuration/update"
	get "docket" => "docket#index"

	resources :memberships
	resources :exams
	resources :assignments
	resources :courses
	resources :teachers
	resources :sessions

	# doesn't work because configuration is singular and rails complains about
	# not being able to find ConfigurationsController (throws an
	# UninitializedConstant exception)
	#resource :configuration

	resources :classrooms do
		member do
			get "join"
			get "leave"
		end
	end

	resources :users do
		member do
			get "activity"
		end
		collection do
			get "activity" => "users#index_activities"
		end
	end

	resources :events do
		member do
			get "join"
			get "leave"
		end
	end

	get "sessions/new"
	get "log_in" => "sessions#new", :as => "log_in"
	get "log_out" => "sessions#destroy", :as => "log_out"

	root "docket#index"

	# Example of regular route:
	#   get "products/:id" => "catalog#view"

	# Example of named route that can be invoked with purchase_url(id: product.id)
	#   get "products/:id/purchase" => "catalog#purchase", as: :purchase

	# Example resource route (maps HTTP verbs to controller actions automatically):
	#   resources :products

	# Example resource route with options:
	#   resources :products dob
	#     member do
	#       get "short"
	#       post "toggle"
	#     end
	#
	#     collection do
	#       get "sold"
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
	#       get "recent", on: :collection
	#     end
	#   end

	# Example resource route with concerns:
	#   concern :toggleable do
	#     post "toggle"
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

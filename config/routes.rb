Rails.application.routes.draw do
  resources :students
  resources :mentors
  resources :enrollments
  resources :mentor_enrollment_assignments
  resources :lessons
  resources :courses do
    resources :submissions
  end
  resources :coding_classes
  resources :trimesters
  namespace :api do
    namespace :v1 do
      get "/courses", to: "courses#index"
      get "/courses/:course_id/enrollments", to: "enrollments#index"
    end
  end

  get "/trimesters", to: "trimesters#index"
  get "/trimesters/:id", to: "trimesters#show"
  get "/dashboard", to: "admin_dashboard#index"
  get "/courses/:id", to: "courses#show"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"



  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"



end

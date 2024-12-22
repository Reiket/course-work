Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  root "home#index"

  resources :patient_registration, only: %i[new create]

  namespace :patient do
    resources :appointments
    resources :profiles, only: %i[index update]
    resources :doctors, only: %i[index show]
    post 'create_appointment', to: 'doctors#create_appointment', as: 'create_appointment'
    post 'create_rating', to: 'doctors#create_rating', as: 'create_rating'
    put 'doctors/edit_rating/:id/', to: 'doctors#edit_rating', as: 'edit_rating'
  end

  namespace :doctor do
    resources :profiles, only: %i[index update]
    resources :schedules, only: %i[index]
    resources :working_hours, only: %i[destroy new create]
    resources :appointments, only: %i[index]
    resources :statistics, only: %i[index]

    put 'schedules/change_status_day/:id/', to: 'schedules#change_status_day', as: 'change_status_day'
    put 'appointments/confirm_appointment/:id/', to: 'appointments#confirm_appointment', as: 'confirm_appointment'
  end
end

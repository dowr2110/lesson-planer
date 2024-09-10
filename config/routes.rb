# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#home'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :teacher_profiles, only: %i[new create edit update]
  resources :student_profiles, only: %i[new create edit update]

  resources :chats, only: %i[index show create] do
    resources :messages, only: [:create] do
      collection do
        get :search
      end
    end
  end

  resources :availability_slots, only: %i[index new create show destroy]
  resources :bookings, only: [:create]

  resources :teachers, only: :index do
    collection do
      get :my_students
    end
  end
  post '/teachers/assign_student/:id', to: 'teachers#assign_student', as: 'assign_student'
end

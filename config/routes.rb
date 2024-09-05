# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#home'

  devise_for :users

  resources :teacher_profiles, only: %i[new create edit update]
  resources :student_profiles, only: %i[new create edit update]

  resources :chats, only: %i[index show create] do
    resources :messages, only: [:create]
  end

  resources :availability_slots, only: %i[index new create show destroy]
  resources :bookings, only: [:create]
end

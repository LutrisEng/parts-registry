# frozen_string_literal: true

Rails.application.routes.draw do
  root 'index#index'
  resources :part_attachments
  resources :parts, param: :part_number

  namespace :admin do
    get '/user', to: 'user#show'
    resources :parts, param: :part_number do
      member do
        post :create_shopify
      end
    end
  end
end

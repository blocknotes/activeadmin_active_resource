# frozen_string_literal: true

Rails.application.routes.draw do
  resources :authors
  resources :posts
  resources :tags, only: %w[index show]
end

# frozen_string_literal: true

Spree::Core::Engine.routes.draw do
  resources :addresses

  if Rails.env.test?
    put '/cart', to: 'orders#update', as: :put_cart
  end
end

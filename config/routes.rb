Rails.application.routes.draw do
  get '/', to: 'welcome#index'
  resources :merchants do
    resources :dashboard, only: [:index]
    resources :discounts, only: [:index, :show], controller: :merchant_discounts
    resources :items
    resources :invoices, only: [:index, :show]
    resources :invoice_items, only: [:update]
  end

  resources :admin, only: [:index]
  namespace :admin do
    resources :merchants do
    end
    resources :merchants, only: [:index, :show, :edit, :update]
    resources :invoices, only: [:index, :show, :update]
  end
end

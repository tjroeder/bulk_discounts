Rails.application.routes.draw do
  get '/', to: 'welcome#index'
  resources :merchants do
    resources :dashboard, only: [:index], controller: :merchant_dashboard
    resources :discounts, only: [:index, :show, :new], controller: :merchant_discounts
    resources :items, controller: :merchant_items
    resources :invoices, only: [:index, :show], controller: :merchant_invoices
    resources :invoice_items, only: [:update], controller: :merchant_invoice_items
  end

  resources :admin, only: [:index]
  namespace :admin do
    resources :merchants, only: [:index, :show, :new, :create, :edit, :update]
    resources :invoices, only: [:index, :show, :update]
  end
end

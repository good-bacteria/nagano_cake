Rails.application.routes.draw do
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    root :to => "homes#top"
    get "about" => "homes#about"
    resources :items, only: [:index, :show]
    get "customers/my_page" => "customers#show"
    get "customers/info/edit" => "customers#edit"
    patch "customers/info" => "customers#update"
    get "customers/quit" => "customers#quit"
    patch "customers/withdraw" => "customers#withdraw"
    resources :cart_items, only: [:index, :update, :create, :destroy]
    delete "cart_items" => "cart_items#destroy_all"
    post "orders/confirm" => "orders#confirm"
    get "orders/thanks" => "orders#thanks"
    resources :orders, only: [:new, :create, :index, :show]
    resources :ships, only: [:index, :edit, :create, :update, :destroy]
  end

  namespace :admin do
    get "/" => "homes#top"
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_items, only: [:update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

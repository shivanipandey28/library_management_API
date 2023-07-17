Rails.application.routes.draw do
  devise_for :users,
             controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
             }
  
  resources :books
  get 'index', to: 'user_books#index', as: 'index'
  post '/borrowed_book', to: 'user_books#borrowed_book', as: 'borrowed_book'
  # patch '/return_book', to: 'user_books#return_book', as: 'return_book'
end
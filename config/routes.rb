Rails.application.routes.draw do
  resources :albums
  get 'home/main'
  get '/albums/:id' ,to: 'albums#destroy', as: 'albums_destroy'

  resources :albums do
    member do
       delete :delete_album_photos
    end
 end

  devise_for :users do
    resources :albums 
  end
  get '/albums/:id/delete_album_photos', to: 'albums#delete_album_photos'

  root 'home#main'
  
  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
    end

end

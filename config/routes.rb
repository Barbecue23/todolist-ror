Rails.application.routes.draw do
  root "todos#index"

  resources :todos, only: %i[index create update destroy] do
    member do
      patch :toggle
    end
    collection do
      delete :clear_completed
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end

# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope '/api/v1' do
    get '/user' => 'users#show'

    post '/loan' => 'loans#create'
  end
end
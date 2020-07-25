Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "api/v1/graphql#execute"
  end
  namespace :api do
    namespace :v1 do
      post "/graphql", to: "graphql#execute"
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

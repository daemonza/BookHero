BookHero::Application.routes.draw do
  get "config/settings"
  post "config/settings"
  post "config/save"
  get "config/configure"
  get "books/scan"
  post "books/scan"
  get "books/list"
  get "books/remove"
  get "books/download"
  post "books/search"


   root to: "books#main"


end

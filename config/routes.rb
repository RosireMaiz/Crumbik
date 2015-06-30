Rails.application.routes.draw do
  root 'paginas#index'
  get '/perfil', to: 'paginas#perfil'
  get '/catalogo', to: 'paginas#catalogo'

end

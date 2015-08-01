Rails.application.routes.draw do
  devise_for :usuarios,  controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  root 'paginas#index'
  get '/perfil', to: 'paginas#perfil'
  get '/catalogo', to: 'paginas#catalogo'
  match '/usuarios/:id/finish_signup' => 'usuarios#finish_signup', via: [:get, :patch], as: :finish_signup
end

class SubdomainPresent
  def self.matches?(request)
    request.subdomain.present?
  end
end


Rails.application.routes.draw do

	root 'paginas#index'

	match "/validar_email" => "usuarios#validar_email", via: :post
	match "/validar_subdominio" => "organizacions#validar_subdominio", via: :post

	match "/usuarios/abrircuenta"=>"usuarios#create", via: :post
	match "/registro" => "usuarios#new", via: :get
  
	devise_scope :usuario do
	    post "/entrar" => "devise/sessions#create"
	    get "/entrar" => "devise/sessions#new"
	    #get "/registro" => "devise/registrations#new"
	end

	devise_for :usuarios,  controllers: { omniauth_callbacks: 'omniauth_callbacks' }, via: :post

	match '/usuarios/:id/confirmar_registro' => 'usuarios#finish_signup', via: [:get, :patch], as: :finish_signup


	get '/perfil', to: 'paginas#perfil'
	get '/catalogo', to: 'paginas#catalogo'
	match "/inicio" => "paginas#index", via: :get

	constraints(SubdomainPresent) do
	end

end

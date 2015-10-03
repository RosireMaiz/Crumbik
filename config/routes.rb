class SubdomainPresent
  def self.matches?(request)
    request.subdomain.present?
  end
end


Rails.application.routes.draw do

	root 'portal#index'

	match "/validar_email" => "usuarios#validar_email", via: :post
	match "/validar_subdominio" => "organizacions#validar_subdominio", via: :post

	match "/usuarios/abrircuenta"=>"usuarios#create", via: :post
  	match '/usuarios/:id/confirmar_registro' => 'usuarios#finish_signup', via: [:get, :patch], as: :finish_signup
	match "/registro" => "usuarios#new", via: :get

	get '/catalogo', to: 'paginas#catalogo'
	match "/inicio" => "portal#index", via: :get

	match '/menu/ajax' => "menu#ajax", via: :post
	match '/menu/ajax' => "menu#ajax", via: :get

	match '/estructurajerarquica' => "menu#estructura_jerarquica", via: :post
	match '/estructurajerarquica' => "menu#estructura_jerarquica", via: :get

	match '/menu/cargar_estructura' => "menu#cargar_estructura", via: :get

	match '/menu/consultar' => "menu#consultar", via: :post
	match '/menu/consultar' => "menu#consultar", via: :get

	match "/usuarios/editar" => "usuarios#edit", via: :get
    match "/usuarios/editar" => "usuarios#save", via: :post
    match "/usuarios/perfil" => "usuarios#show", via: :get
    match "/usuario/guardar_foto" => "usuarios#save_foto", via: :post
    match "/usuario/guardar_foto" => "usuarios#save_foto", via: :get

	devise_scope :usuario do
	    post "/entrar" => "devise/sessions#create"
	    get "/entrar" => "devise/sessions#new"
	end

	devise_for :usuarios,  controllers: { :omniauth_callbacks => 'omniauth_callbacks',
             :registrations => 'registrations'}, via: :post



	constraints(SubdomainPresent) do
	end

end

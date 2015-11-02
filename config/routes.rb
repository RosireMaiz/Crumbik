class SubdomainPresent
  def self.matches?(request)
    request.subdomain.present?
  end
end


Rails.application.routes.draw do

	root 'portal#index'

	match "/validar_email" => "usuarios#validar_email", via: :post
	match "/validar_subdominio" => "organizacions#validar_subdominio", via: :post
	match "/validar_rol" => "rols#validar_rol", via: :post
	match "/validar_rol_update" => "rols#validar_rol_update", via: :post
	match "/validar_servicio" => "servicios#validar_servicio", via: :post
	match "/validar_servicio_update" => "servicios#validar_servicio_update", via: :post
	match "/validar_red_social" => "red_socials#validar_red_social", via: :post
	match "/validar_red_social_update" => "red_socials#validar_red_social_update", via: :post
	match "/validar_opcion" => "menu#validar_opcion", via: :post

	match "/usuarios/abrircuenta"=>"usuarios#create", via: :post
  	match '/usuarios/:id/confirmar_registro' => 'usuarios#finish_signup', via: [:get, :patch], as: :finish_signup
	match "/registro" => "usuarios#new", via: :get
	get 'current_rol' => "usuarios#current_rol"

	get '/catalogo', to: 'paginas#catalogo'
	match "/inicio" => "portal#index", via: :get

	match '/menu/ajax' => "menu#ajax", via: :post
	match '/menu/ajax' => "menu#ajax", via: :get

	match '/estructurajerarquica' => "menu#estructura_jerarquica", via: :post
	match '/estructurajerarquica' => "menu#estructura_jerarquica", via: :get

	match '/menu/cargar_estructura' => "menu#cargar_estructura", via: :get
	match '/menu/consultar' => "menu#consultar", via: :post
	match '/menu/actualizar' => "menu#actualizar", via: :post

	match "/usuarios/editar" => "usuarios#edit", via: :get
    match "/usuarios/editar" => "usuarios#save", via: :post
    
    match "/usuarios/perfil" => "usuarios#show", via: :get
 	match "/usuarios/perfil/:id" => "usuarios#show", via: :post

    match "/usuario/guardar_foto" => "usuarios#save_foto", via: :post
    match "/usuario/guardar_foto" => "usuarios#save_foto", via: :get

    match "/usuarios_portal/consultar" => "usuarios#usuarios", via: :get
    match "/usuarios_portal/agregarusuario" => "usuarios#new_user", via: :get
 
 	match "/usuarios/create_portal"=>"usuarios#create_portal", via: :post

    match "/roles/consultar" => "rols#consultar", via: :get
    match "/roles/agregar" => "rols#new", via: :get
    match "/roles/crear_rol" => "rols#create", via: :post
    match "/roles/update_estatus" => "rols#update_estatus", via: :post
	match "/roles/update" => "rols#update", via: :post
	match "/roles/consultar_rol" => "rols#consultar_rol", via: :post

    match "/servicios/consultar" => "servicios#consultar", via: :get
    match "/servicios/agregar" => "servicios#new", via: :get
    match "/servicios/crear_servicio" => "servicios#create", via: :post
    match "/servicios/update_estatus" => "servicios#update_estatus", via: :post
	match "/servicios/update" => "servicios#update", via: :post
	match "/servicios/consultar_servicio" => "servicios#consultar_servicio", via: :post


    match "/redes_sociales" => "red_socials#consultar", via: :get
    match "/redes_sociales/agregar" => "red_socials#new", via: :get
    match "/red_socials/crear_red_social" => "red_socials#create", via: :post
    match "/redes_sociales/update_estatus" => "red_socials#update_estatus", via: :post
	match "/redes_sociales/update" => "red_socials#update", via: :post
	match "/redes_sociales/consultar_red_social" => "red_socials#consultar_red_social", via: :post

	devise_scope :usuario do
	    post "/entrar" => "devise/sessions#create"
	    get "/entrar" => "devise/sessions#new"
	end

	devise_for :usuarios,  controllers: { :omniauth_callbacks => 'omniauth_callbacks',
             :registrations => 'registrations'}, via: :post



	constraints(SubdomainPresent) do

	end

end

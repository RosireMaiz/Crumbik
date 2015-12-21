class SubdomainPresent
  def self.matches?(request)
    request.subdomain.present?
  end
end


Rails.application.routes.draw do

	root 'portal#index'

	match "/validar_email" => "usuarios#validar_email", via: :post
	match "/validar_email_update" => "usuarios#validar_email_update", via: :post
	match "/validar_subdominio" => "organizacions#validar_subdominio", via: :post
	match "/validar_rol" => "rols#validar_rol", via: :post
	match "/validar_rol_update" => "rols#validar_rol_update", via: :post
	match "/validar_servicio" => "servicios#validar_servicio", via: :post
	match "/validar_servicio_update" => "servicios#validar_servicio_update", via: :post

	match "/validar_red_social" => "red_socials#validar_red_social", via: :post
	match "/validar_red_social_update" => "red_socials#validar_red_social_update", via: :post
	match "/validar_pais" => "pais#validar_pais", via: :post
	match "/validar_pais_update" => "pais#validar_pais_update", via: :post
	match "/validar_dispositivo" => "dispositivos#validar_dispositivo", via: :post
	match "/validar_dispositivo_update" => "dispositivos#validar_dispositivo_update", via: :post
	match "/validar_frecuencia_pago" => "frecuencia_pagos#validar_frecuencia_pago", via: :post
	match "/validar_modo_pago_update" => "modo_pagos#validar_modo_pago_update", via: :post
	match "/validar_modo_pago" => "modo_pagos#validar_modo_pago", via: :post
	match "/validar_plan" => "plans#validar_plan", via: :post
	match "/validar_plan_update" => "plans#validar_plan_update", via: :post
	match "/validar_tipo_organizacion_update" => "tipo_organizacions#validar_tipo_organizacion_update", via: :post
	match "/validar_tipo_organizacion" => "tipo_organizacions#validar_tipo_organizacion", via: :post
	match "/validar_pregunta_frecuente_update" => "pregunta_frecuentes#validar_pregunta_frecuente_update", via: :post
	match "/validar_pregunta_frecuente" => "pregunta_frecuentes#validar_pregunta_frecuente", via: :post

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
	match "/roles/eliminar" => "rols#eliminar", via: :post

    match "/servicios/consultar" => "servicios#consultar", via: :get
    match "/servicios/agregar" => "servicios#new", via: :get
    match "/servicios/crear_servicio" => "servicios#create", via: :post
    match "/servicios/update_estatus" => "servicios#update_estatus", via: :post
	match "/servicios/update" => "servicios#update", via: :post
	match "/servicios/consultar_servicio" => "servicios#consultar_servicio", via: :post
	match "/servicios/eliminar" => "servicios#eliminar", via: :post

    match "/redes_sociales" => "red_socials#consultar", via: :get
    match "/redes_sociales/agregar" => "red_socials#new", via: :get
    match "/red_socials/crear_red_social" => "red_socials#create", via: :post
   	match "/red_socials/editar_red_social" => "red_socials#update", via: :post
  	match "/red_social/editar/:id_red_social" => "red_socials#edit", via: :post
    match "/redes_sociales/update_estatus" => "red_socials#update_estatus", via: :post

	match "/redes_sociales/consultar_red_social" => "red_socials#consultar_red_social", via: :post
	match "/redes_sociales/eliminar" => "red_socials#eliminar", via: :post

    match "/paises" => "pais#consultar", via: :get
    match "/paises/agregar" => "pais#new", via: :get
    match "/pais/crear_pais" => "pais#create", via: :post
    match "/paises/update_estatus" => "pais#update_estatus", via: :post
	match "/paises/update" => "pais#update", via: :post
	match "/paises/consultar_pais" => "pais#consultar_pais", via: :post
	match "/paises/eliminar" => "pais#eliminar", via: :post

    match "/dispositivos" => "dispositivos#consultar", via: :get
    match "/dispositivos/agregar" => "dispositivos#new", via: :get
    match "/dispositivos/crear_dispositivo" => "dispositivos#create", via: :post
    match "/dispositivos/eliminar" => "dispositivos#eliminar", via: :post
	match "/dispositivos/update" => "dispositivos#update", via: :post
	match "/dispositivos/consultar_dispositivo" => "dispositivos#consultar_dispositivo", via: :post
	match "/dispositivos/eliminar" => "dispositivos#eliminar", via: :post

    match "/frecuencias_pago" => "frecuencia_pagos#consultar", via: :get
    match "/frecuencia_pago/agregar" => "frecuencia_pagos#new", via: :get
    match "/frecuencia_pago/crear_frecuencia_pago" => "frecuencia_pagos#create", via: :post
    match "/frecuencia_pagos/update_estatus" => "frecuencia_pagos#update_estatus", via: :post
	match "/frecuencia_pagos/update" => "frecuencia_pagos#update", via: :post
	match "/frecuencia_pagos/consultar_frecuencia_pago" => "frecuencia_pagos#consultar_frecuencia_pago", via: :post
	match "/frecuencia_pagos/eliminar" => "frecuencia_pagos#eliminar", via: :post

    match "/modos_pago" => "modo_pagos#consultar", via: :get
    match "/modo_pago/agregar" => "modo_pagos#new", via: :get
    match "/modo_pago/crear_modo_pago" => "modo_pagos#create", via: :post
    match "/modo_pagos/update_estatus" => "modo_pagos#update_estatus", via: :post
	match "/modo_pagos/update" => "modo_pagos#update", via: :post
	match "/modo_pagos/consultar_modo_pago" => "modo_pagos#consultar_modo_pago", via: :post
	match "/modo_pagos/eliminar" => "modo_pagos#eliminar", via: :post

	match "/tipos_organizaciones" => "tipo_organizacions#consultar", via: :get
    match "/tipo_organizacion/agregar" => "tipo_organizacions#new", via: :get
    match "/tipo_organizacion/crear_tipo_organizacion" => "tipo_organizacions#create", via: :post
    match "/tipo_organizacions/update_estatus" => "tipo_organizacions#update_estatus", via: :post
	match "/tipo_organizacions/update" => "tipo_organizacions#update", via: :post
	match "/tipo_organizacions/consultar_tipo_organizacion" => "tipo_organizacions#consultar_tipo_organizacion", via: :post
	match "/tipo_organizacions/eliminar" => "tipo_organizacions#eliminar", via: :post

	match "/preguntas_frecuentes" => "pregunta_frecuentes#consultar", via: :get
    match "/preguntas_frecuentes/agregar" => "pregunta_frecuentes#new", via: :get
    match "/pregunta_frecuente/crear_pregunta_frecuente" => "pregunta_frecuentes#create", via: :post
    match "/pregunta_frecuentes/update_estatus" => "pregunta_frecuentes#update_estatus", via: :post
	match "/pregunta_frecuentes/update" => "pregunta_frecuentes#update", via: :post
	match "/pregunta_frecuentes/consultar_pregunta_frecuente" => "pregunta_frecuentes#consultar_pregunta_frecuente", via: :post
	match "/pregunta_frecuentes/eliminar" => "pregunta_frecuentes#eliminar", via: :post

	match "/planes" => "plans#consultar", via: :get
    match "/planes/agregar" => "plans#new", via: :get
    match "/plans/crear_plan" => "plans#create", via: :post
    match "/plans/update_estatus" => "plans#update_estatus", via: :post
	match "/plans/eliminar" => "plans#eliminar", via: :post
  	match "/plan/editar/:id_plan" => "plans#edit", via: :get
	match "/plan/editar" => "plans#save_edit", via: :post
	match "/plan/guardar_imagen" => "plans#save_imagen", via: :post


	match "/organizaciones" => "organizacions#consultar", via: :get
	match "/organizacion/consultar/:subdominio" => "organizacions#show", via: :get
	match "/organizacion/editar/:subdominio" => "organizacions#edit", via: :get
  	match "/organizacion/editar" => "organizacions#save", via: :post

	match "/sugerencias" => "sugerencias#consultar", via: :get

	devise_scope :usuario do
	    post "/entrar" => "devise/sessions#create"
	    get "/entrar" => "devise/sessions#new"
	end

	devise_for :usuarios,  controllers: { :omniauth_callbacks => 'omniauth_callbacks',
             :registrations => 'registrations'}, via: :post

	constraints(SubdomainPresent) do
		match "/organizacion/consultar" => "organizacions#show", via: :get
		match "/organizacion/apariencia/portal" => "organizacions#apariencia_index", via: :get
		match "/organizacion/apariencia/editar_ubicacion" => "organizacions#editar_ubicacion", via: :get
		match "/organizacion/apariencia/editar_banner" => "organizacions#editar_banner", via: :get
		match "/organizacion/save_banner" => "organizacions#save_banner", via: :post
		match "/organizacion/editar_ubicacion" => "organizacions#editar_ubicacion_iframe", via: :post
		match "/organizacion/eliminar_ubicacion_iframe" => "organizacions#eliminar_ubicacion_iframe", via: :post
		
		match "/sugerencia/agregar"=> "sugerencias#new", via: :get
		match "/sugerencias/crear_sugerencia" => "sugerencias#create", via: :post

		match "/organizacion/apariencia/tema"=> "organizacions#apariencia_tema", via: :get

		match "/productos/consultar" => "productos#consultar", via: :get
	    match "/productos/agregar" => "productos#new", via: :get
	    match "/productos/crear_producto" => "productos#create", via: :post
	    match "/productos/editar/:id_producto" => "productos#edit", via: :get
	    match "/producto/editar" => "productos#save_edit", via: :post
	    match "/productos/update_estatus" => "productos#update_estatus", via: :post
		match "/productos/eliminar" => "productos#eliminar", via: :post
		

		match "/productos/publicidad/consultar" => "publicidads#consultar", via: :get
	    match "/productos/publicidad/agregar" => "publicidads#new", via: :get
	    match "/publicidad/crear_publicidad" => "publicidads#create", via: :post
	    match "/publicidad/editar/:id_producto" => "publicidads#edit", via: :get
	    match "/publicidad/editar" => "publicidads#save_edit", via: :post
	    match "/publicidad/update_estatus" => "publicidads#update_estatus", via: :post
		match "/publicidad/eliminar" => "publicidads#eliminar", via: :post

		
	end

end

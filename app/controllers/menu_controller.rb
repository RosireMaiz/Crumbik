class MenuController < ApplicationController

 def validar_opcion

 	id = $menuJerarquia.id
	if $funcion == "actualizar"

		if OpcionMenu.exists?( ["nombre = ? AND menu_id = ? AND id <> ? AND padre_id = ?", params[:nombre], id, $idNode, $id_padre])
		    render json: false
		else
		    render json: true
		end

	else

		if OpcionMenu.exists?( ["nombre = ? AND menu_id = ? AND padre_id = ?", params[:nombre], id, $idNode])
		    render json: false
		else
		    render json: true
		end
	end
 end

 def index
 end

 def ajax
	@opcionMenus = OpcionMenu.new
	if request.subdomain.present?
		@menu = Menu.where(rol_id: current_usuario.rol_actual.id, type_menu: Menu.type_menus[:subdominio]).first
	else
		@menu = Menu.where(rol_id: current_usuario.rol_actual.id, type_menu: Menu.type_menus[:portal]).first
	end
	
	@tira = @opcionMenus.BuscarTodosArbolJson(@menu)
	render :text => @tira
 end
 
  def portal
	@opcionMenus = OpcionMenu.new
	if request.subdomain.present?
		@menu = Menu.where(rol_id: '5', type_menu: Menu.type_menus[:subdominio]).first
	else
		@menu = Menu.where(rol_id: '5', type_menu: Menu.type_menus[:portal]).first
	end
	
	@tira = @opcionMenus.BuscarTodosArbolJson(@menu)
	render :text => @tira
 end

 def estructura_jerarquica

 end

 def cargar_estructura
	@opcionMenus = OpcionMenu.new
	$idRol = params[:idRol]
	$typeMenu = params[:typeMenu]
	$menuJerarquia = Menu.where("rol_id = ? AND type_menu=?", $idRol, $typeMenu).first
	if $menuJerarquia.blank?
		$menuJerarquia = Menu.new
		$menuJerarquia.type_menu = $typeMenu.to_i
		$menuJerarquia.rol_id = $idRol
		$menuJerarquia.save
	end
	@tira = @opcionMenus.BuscarTodosArbolJsonSinHref($menuJerarquia)
	render :text => @tira
 end

 def consultar
 	$funcion = params[:funcion]
 	$idNode = params[:idnodo]

	if $funcion == "agregar"
		render :text => '{ "success" : "true"}'
	else
	 	@node = OpcionMenu.where(id: $idNode).first
 		$id_padre = @node.padre_id
 		@opcionMenus = OpcionMenu.new
 		@nodo = @opcionMenus.BuscarNodo($idNode)
		render :text => @nodo
	end
 	
 end


 def actualizar
	@funcion = params[:funcion]
	#Actualizar Nodo   
	if @funcion == "actualizar"
		idnodo = params[:idnodo]
	   	nombrenodo = params[:nombre]
		icono = params[:icono]
		url=params[:url]
	  	@opcionActualizar = OpcionMenu.new
	   	valor = @opcionActualizar.Actualizar(idnodo, nombrenodo, icono, url)
	    if valor == 1
	    	render :text => '{"success": "true", "exito": "true", "msg": "Transaccion exitosa" }';
	    else
	    	render :text => '{"success": "true", "exito": "false", "msg": "Transaccion No Exitosa" }'
	   	end
	end
	  
	  #Agregar Nodo
	if @funcion == "agregar"	   
	   nombrenodo = params[:nombre]
	   menu = $menuJerarquia.id
	   icono = params[:icono]
	   padre_id = params[:padre_id]
	   url=params[:url]
	   @opcionNueva = OpcionMenu.new
	   valor = @opcionNueva.Agregar(nombrenodo, menu, icono, padre_id, url)   
	   if valor == 1
	    render :text => '{"success": "true", "exito": "true", "msg": "Eliminacion exitosa"}'   
	   else
	    render :text => '{"success": "true", "exito": "false", "msg": "Transaccion No Exitosa" }'
	   end
	end

	  #Eliminar Nodo
	if @funcion == "eliminar"
	   idnodo = params[:idnodo]
	   @opcionMenu = OpcionMenu.new
	   valor = @opcionMenu.Eliminar(idnodo)
	   if valor == 1
	    render :text => '{"success": "true", "exito": "true", "msg": "Eliminacion exitosa"}'
	   else
	    render :text => '{"success": "true", "exito": "false", "msg": "Eliminacion No Exitosa" }'
	   end
	end

 end


end
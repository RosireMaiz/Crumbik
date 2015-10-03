class MenuController < ApplicationController

 def index
 end

 def ajax
	@opcionMenus = OpcionMenu.new
	@tira = @opcionMenus.BuscarTodosArbolJson(@menuprueba)
	render :text => @tira
 end
 

 def estructura_jerarquica

 end

 def cargar_estructura
	@opcionMenus = OpcionMenu.new
	@idRol = params[:idRol]
	@menuJerarquia = Menu.where(rol_id: @idRol).last
	@tira = @opcionMenus.BuscarTodosArbolJsonSinHref(@menuJerarquia)
	render :text => @tira
 end

 def consultar
 	@idNode = params[:idnodo]
 	@opcionMenus = OpcionMenu.new
 	@nodo = @opcionMenus.BuscarNodo(@idNode)
	render :text => @nodo
 end


 def actualizar
	@funcion = params[:funcion]
	#Actualizar Nodo   
	if @funcion == "actualizar"
		idnodo = params[:idnodo]
	   	nombrenodo = params[:nombrenodo]
		padre_id = [:padre_id]
	  	@arbols = Arbols.new
	   	valor = @arbols.Actualizar(idnodo, nombrenodo, tipo, padre_id)
	    if valor == 1
	    	render :text => '{"success": "true", "exito": "true", "msg": "Transaccion exitosa" }';
	    else
	    	render :text => '{"success": "true", "exito": "false", "msg": "Transaccion No Exitosa" }'
	   	end
	end
	  
	  #Agregar Nodo
	if @funcion == "agregar"
	   idnodo = params[:idnodo]
	   nombrenodo = params[:nombrenodo]
	   tipo = params[:tipo]
	   padre_id = params[:padre_id]
	   @arbols = Arbols.new
	   valor, vinculo = @arbols.Agregar(idnodo, nombrenodo, tipo, padre_id, vinculo)   
	   if valor >= 1
	    render :text => "{'success': 'true', 'exito': 'true', 'msg': 'Transaccion exitosa',  'son': '#{valor}', 'vinculo': '#{vinculo}' }"    
	   else
	    render :text => '{"success": "true", "exito": "false", "msg": "Transaccion No Exitosa" }'
	   end
	end

	  #Eliminar Nodo
	if @funcion == "eliminar"
	   idnodo = params[:idnodo]
	   @arbols = Arbols.new
	   valor = @arbols.Eliminar idnodo
	   if valor.to_i >= 1
	    render :text => "{'success': 'true', 'exito': 'true', 'msg': 'Eliminacion exitosa',  'son': '#{valor}'}"
	   else
	    render :text => '{"success": "true", "exito": "false", "msg": "Eliminacion No Exitosa" }'
	   end
	end

 end


end
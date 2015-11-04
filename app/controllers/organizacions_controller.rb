class OrganizacionsController < ApplicationController

	def validar_subdominio
	    if Organizacion.exists?(subdominio: params[:usuario][:organizacion_attributes][:subdominio])
	      render json: false
	    else
	      render json: true
	    end
	end

  	def consultar
		if !usuario_signed_in?
        	render "portal/index"
     	else
     		@tipo_organizacions = TipoOrganizacion.order('id ASC')
     		@usuario = current_usuario
	       	
	       	if request.subdomain.present?

	       		@rol =  Rol.where(nombre: 'Empresario')
	        
		        @usuarioRol = UsuarioRol.where(usuario_id: current_usuario.id, rol_id: current_usuario.rol_actual.id) 

		        if @usuarioRol[0] == nil or @rol[0].id != current_usuario.rol_actual.id
		          render "portal/index_principal"
		        else
					@organizacion = Organizacion.where(["subdominio = ?", request.subdomain]).first
		        	@organizacions = Organizacion.where(usuario_id: @organizacion.usuario_id).order('id ASC')
					@valor = true;
					render "organizacions/organizacions"	
	        	end
	        	
	       	else
	       		@rol =  Rol.where(nombre: 'Administrador del sistema')
	        
		        @usuarioRol = UsuarioRol.where(usuario_id: current_usuario.id, rol_id: current_usuario.rol_actual.id) 

		        if @usuarioRol[0] == nil or @rol[0].id != current_usuario.rol_actual.id
		          render "portal/index_principal"
		        else
					@organizacions = Organizacion.order('id ASC')
					@valor = true;
					render "organizacions/organizacions"	
	        	end
				
	        end
         
     	end
	end

end

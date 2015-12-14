class SugerenciasController < ApplicationController

	def new
		if !usuario_signed_in?
			redirect_to root_path
		else
			@sugerencia = Sugerencium.new
			if !request.subdomain.present?
				redirect_to root_path
			else
				render "sugerencias/new"
			end
		end
	end

	def consultar
		if !usuario_signed_in?
        	redirect_to root_path
     	else
     		if request.subdomain.present?
     			id_user = current_usuario.id
     			@sugerencias = Sugerencium.where(usuario_id: id_user).order('id ASC')
		        render "sugerencias/sugerencias"	
     		else
     			@rol =  Rol.where(nombre: 'Administrador del sistema')
	        
		        @usuarioRol = UsuarioRol.where(usuario_id: current_usuario.id, rol_id: current_usuario.rol_actual.id) 

		        if @usuarioRol[0] == nil or @rol[0].id != current_usuario.rol_actual.id
		          redirect_to root_path
		        else
		           @sugerencias = Sugerencium.order('id ASC')
		           render "sugerencias/sugerencias"	
		        end

     		end
	        
         
     	end
	end
end

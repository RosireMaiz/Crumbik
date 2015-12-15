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
     			
     			Apartment::Tenant.switch!()
     			organizacion = Organizacion.where(["subdominio = ?", request.subdomain]).first
     			
     			
     			@sugerencias = Sugerencium.where(usuario_id: organizacion.usuario_id).order('created_at DESC')
     			
		        render "sugerencias/sugerencias"	
     		else
     			@rol =  Rol.where(nombre: 'Administrador del sistema')
	        
		        @usuarioRol = UsuarioRol.where(usuario_id: current_usuario.id, rol_id: current_usuario.rol_actual.id) 

		        if @usuarioRol[0] == nil or @rol[0].id != current_usuario.rol_actual.id
		          redirect_to root_path
		        else
		           @sugerencias = Sugerencium.order('created_at DESC')
		           render "sugerencias/sugerencias"	
		        end

     		end
	        
         
     	end
	end

	def create
		@sugerencia = Sugerencium.new(sugerencia_params)
		if request.subdomain.present?
     		Apartment::Tenant.switch!()
     		organizacion = Organizacion.where(["subdominio = ?", request.subdomain]).first
     		@sugerencia.usuario_id = organizacion.usuario_id
     	else
     		@sugerencia.usuario_id = current_usuario.id
     	end
	    @sugerencia.save
	  	redirect_to :controller => 'sugerencias', :action => 'consultar'
	end

	private
		def sugerencia_params
	      accessible = [ :titulo, :contenido ] # extend with your own params
	      params.require(:sugerencium).permit(accessible)
	    end

end

require "base64"
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

	def show
		if params[:subdominio].present?
			@organizacion = Organizacion.where(["subdominio = ?", params[:subdominio]]).first
			@usuario_organizacion = @organizacion.usuario
		else
			Apartment::Tenant.switch!()
			@organizacion = Organizacion.where(["subdominio = ?", request.subdomain]).first
			@usuario_organizacion = Usuario.includes(:perfil).where(["id = ?", @organizacion.usuario_id]).first
		end

		@redes = OrganizacionRedSocial.includes(:red_social).where("organizacion_id = ?", @organizacion.id)
		render "organizacions/show"	
	end

	def edit
		@organizacion = Organizacion.where(["subdominio = ?", params[:subdominio]]).first
		@redes = OrganizacionRedSocial.includes(:red_social).where("organizacion_id = ?", @organizacion.id)
		@red_socials = RedSocial.where("estatus = ?", 'A')
		render "organizacions/edit"	
	end

	def save
		id_organizacion = params[:organizacion_id]

		@organizacion = Organizacion.where(["id = ?", id_organizacion]).first

		@organizacion.update(organizacion_params)
		redes_sociales = params[:organizacion][:red_social_attributes][:actual]

		if ! redes_sociales.nil?
			redes_sociales.each do |red_social|
			 	id = red_social[0]
			 	url = red_social[1]
			 	red_social_org = OrganizacionRedSocial.where("id = ?", id).first
			 	if url.nil? || url == ""
					red_social_org.destroy
			 	else
			 		red_social_org.update(:url => url)
			 	end
			end
		end
		redes_sociales_nuevas = params[:organizacion][:red_social_attributes][:nueva]

		if ! redes_sociales_nuevas.nil?

			redes_sociales_nuevas.each do |red_social_nueva|
				id = red_social_nueva[0]
		 		url = red_social_nueva[1]
		 		
		 		if ! url.nil?
		 			red_social_org = OrganizacionRedSocial.new
		 			red_social_org.url = url
		 			red_social_org.red_social_id = id
		 			red_social_org.organizacion_id = id_organizacion
		 			red_social_org.save
		 		end
		  	end
		end

		redirect_to :controller => 'organizacions', :action => 'consultar', subdominio: @organizacion.subdominio 
		 
	end

	def save_logo

		@id = params[:organizacion_id]

		@organizacion = Organizacion.where(["id = ?", @id]).first
					
		#Archivo subido por el usuario.
	    archivo = params[:logo_id]

 		formato = "data:"+ archivo.content_type+";base64,"
		logo = Base64.encode64(File.open(archivo.tempfile, "rb").read)

    	@organizacion.logo = logo

    	@organizacion.formato_logo = formato

    	@organizacion.save
		
		redirect_to :controller => 'organizacions', :action => 'edit', subdominio: @organizacion.subdominio 
	end

	def apariencia_index
		@organizacion = Organizacion.where(["subdominio = ?", request.subdomain]).first
		render "organizacions/apariencia_index"
	end

	def editar_ubicacion
		@organizacion = Organizacion.where(["subdominio = ?", request.subdomain]).first
		render "organizacions/editar_ubicacion"
	end

	def editar_ubicacion_iframe
		@id = params[:organizacion_id]

		@organizacion = Organizacion.where(["id = ?", @id]).first

		puts "id" + @id.to_s

		if params[:organizacion][:iframe].present?
			iframe = params[:organizacion][:iframe]
		else
			iframe = nil
		end
			
		puts "iframe" + iframe.to_s

		@organizacion.iframe = iframe

		@organizacion.save
		if iframe.nil?
			render :text =>'{ "success" : "true"}'
		end

		redirect_to :controller => 'organizacions', :action => 'apariencia_index'
	end

	def eliminar_ubicacion_iframe
		@id = params[:organizacion_id]

		@organizacion = Organizacion.where(["id = ?", @id]).first

		iframe = nil	

		@organizacion.iframe = iframe

		@organizacion.save
		render :text =>'{ "success" : "true"}'

	end


	def editar_banner
		@organizacion = Organizacion.where(["subdominio = ?", request.subdomain]).first
		render "organizacions/editar_banner"
	end

	def save_banner

		@id = params[:organizacion_id]

		@organizacion = Organizacion.where(["id = ?", @id]).first
					
		#Archivo subido por el usuario.
	    archivo = params[:banner_id]

 		formato = "data:"+ archivo.content_type+";base64,"
		banner = Base64.encode64(File.open(archivo.tempfile, "rb").read)

    	@organizacion.banner = banner

    	@organizacion.formato_banner = formato

    	@organizacion.save
		
		redirect_to :controller => 'organizacions', :action => 'editar_banner'
	end

	def editar_titulo_banner
		@id = params[:organizacion_id]

		@organizacion = Organizacion.where(["id = ?", @id]).first


		titulo = params[:organizacion][:titulo_banner]
		subtitulo = params[:organizacion][:subtitulo_banner]

		@organizacion.titulo_banner = titulo
		@organizacion.subtitulo_banner = subtitulo

		@organizacion.save

		redirect_to :controller => 'organizacions', :action => 'editar_banner'
	end
	
	private
		def organizacion_params
	      accessible = [ :nombre, :descripcion, :subdominio, :pais_id, :tipo_organizacion_id, :telefono, :slogan, :direccion, :mision, :vision] # extend with your own params
	      params.require(:organizacion).permit(accessible)
    	end

end

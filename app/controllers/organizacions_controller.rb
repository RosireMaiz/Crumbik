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
        	redirect_to root_path
     	else
     		@tipo_organizacions = TipoOrganizacion.order('id ASC')
     		@usuario = current_usuario
	       	
	       	if request.subdomain.present?       	
					@organizacion = Organizacion.where(["subdominio = ?", request.subdomain]).first
		        	@organizacions = Organizacion.where(usuario_id: @organizacion.usuario_id).order('id ASC')
					@valor = true;
					render "organizacions/organizacions"
	       	else
					@organizacions = Organizacion.order('id ASC')
					@valor = true;
					render "organizacions/organizacions"					
	        end
         
     	end
	end

	def show

		if  params[:subdominio].present?
			subdominio = params[:subdominio]
		else
			subdominio = request.subdomain
		end
		if !subdominio.blank?
			if !request.subdomain.present?
				@organizacion = Organizacion.where(["subdominio = ?", subdominio]).first
				@usuario_organizacion = @organizacion.usuario
			else
				Apartment::Tenant.switch!()
				@organizacion = Organizacion.where(["subdominio = ?", subdominio]).first
				@usuario_organizacion = Usuario.includes(:perfil).where(["id = ?", @organizacion.usuario_id]).first
			end
			@redes = OrganizacionRedSocial.includes(:red_social).where("organizacion_id = ?", @organizacion.id)
		end
		
		render "organizacions/show"	
	end

	def edit
		if !request.subdomain.present?
			@organizacion = Organizacion.find_by(["id = ?", 0])
		else
			@organizacion = Organizacion.where(["subdominio = ?", params[:subdominio]]).first
		end
		@redes = OrganizacionRedSocial.includes(:red_social).where("organizacion_id = ?", @organizacion.id)
		@red_socials = RedSocial.where("estatus = ?", 'A')
		render "organizacions/edit"	
	end

	def save
		id_organizacion = params[:organizacion_id]

		@organizacion = Organizacion.where(["id = ?", id_organizacion]).first

		@organizacion.update(organizacion_edit_params)
#		redes = params[:organizacion][:red_social_attributes]

#			redes_sociales = params[:organizacion][:red_social_attributes][:actual]

		redirect_to :controller => 'organizacions', :action => 'consultar'
		 
	end

	def apariencia_index
		if !request.subdomain.present?
			@organizacion = Organizacion.find_by(["id = ?", 0])
		else
			@organizacion = Organizacion.where(["subdominio = ?", request.subdomain]).first
		end
		render "organizacions/apariencia_index"
	end

	def editar_ubicacion
		if !request.subdomain.present?
			@organizacion = Organizacion.find_by(["id = ?", 0])
		else
			@organizacion = Organizacion.find_by(["subdominio = ?", request.subdomain])
		end
		render "organizacions/editar_ubicacion"
	end

	def editar_ubicacion_iframe
		
		@id = params[:organizacion_id]

		@organizacion = Organizacion.find_by(["id = ?", @id])

		if params[:organizacion][:iframe].present?
			iframe = params[:organizacion][:iframe]
		else
			iframe = nil
		end

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
		if !request.subdomain.present?
			@organizacion = Organizacion.find_by(["id = ?", 0])
		else
			@organizacion = Organizacion.find_by(["subdominio = ?", request.subdomain])
		end
		render "organizacions/editar_banner"
	end

	def save_banner
		@id = params[:organizacion_id]

		@organizacion = Organizacion.where(["id = ?", @id]).first


		titulo = params[:organizacion][:titulo_banner]
		subtitulo = params[:organizacion][:subtitulo_banner]

		banner = params[:organizacion][:banner]
		formato_banner = params[:organizacion][:formato_banner]

		@organizacion.titulo_banner = titulo
		@organizacion.subtitulo_banner = subtitulo
		@organizacion.banner = banner
		@organizacion.formato_banner = formato_banner

		@organizacion.save

		redirect_to :controller => 'organizacions', :action => 'apariencia_index'
	end

	def apariencia_tema
		render "organizacions/temas"
	end
	
	def update_tema
		tema = params[:tema]
		@organizacion.tema = tema
		@organizacion.save
		render :text =>'{ "success" : "true"}'
	end

	def contrato_show
		if  !usuario_signed_in?
			redirect_to root_path
		else
			if  params[:subdominio].present?
				subdominio = params[:subdominio]
			else
				subdominio = request.subdomain
			end
			
			@organizacion = Organizacion.includes(:contratos).where(["subdominio = ?", subdominio]).first
			@usuario_organizacion = @organizacion.usuario
			
			render "organizacions/contrato"
		end
		
	end

	def pago_plan
		if  !usuario_signed_in?
			redirect_to root_path
		else
			@contrato_actual = @organizacion.contratos.last
			@contrato = Contrato.new
			@contrato.pagos.build
			@planes = Plan.where(estatus: "A")
			render "organizacions/pago_plan"
		end
		
	end

	def procesar_pago
		@respuesta = Hash.new
		@respuesta["codigo"] = 200
	    @respuesta["url"] = "/organizacion/gestionplanes/informacion"
	    render json: @respuesta
	end

	def organizacion_social_link

		cookies[:id_red_social]  = params[:id_red_social]
		cookies[:action] = "editOrganization"  # creates a cookie storing the "from" value
		cookies[:subdominio] = params[:subdominio]

		red_social = RedSocial.find_by(id: params[:id_red_social])

		if red_social.nombre == "Twitter"
			redirect_to "/usuarios/auth/twitter"
		end

    	if red_social.nombre == "Facebook"
			redirect_to "/usuarios/auth/facebook"
		end

		if red_social.nombre == "Google+"
			redirect_to "/usuarios/auth/google_oauth2"
		end

		if red_social.nombre == "Linkedin"
			redirect_to "/usuarios/auth/linkedin"
		end

		if red_social.nombre == "Instagram"
			redirect_to "/usuarios/auth/instagram"
		end

		if red_social.nombre == "Github"
			redirect_to "/usuarios/auth/github"
		end
		
	end

	def organizacion_social_link_remove
		id_red_social_organizacion  = params[:id_red_social_organizacion]
		@organizacionRedSocial = OrganizacionRedSocial.new
	   	valor = @organizacionRedSocial.Eliminar(id_red_social_organizacion)
		redirect_to :controller => 'organizacions', :action => 'edit'
	end

	def mostrar_informacion
		if request.subdomain.present?
			@comentarios_count = Producto.new.count_total_comentarios
			@like_count = Producto.new.count_total_me_gusta
			@average_count = Producto.new.average_puntuacion
			@share_count = Producto.new.count_total_compartir
		else
			@top_puntuacion = Plan.new.top_puntuacion
			@top_popular = Plan.new.top_popular.first

			@comentarios_count = Plan.new.count_total_comentarios
			@like_count = Plan.new.count_total_me_gusta
			@average_count = Plan.new.average_puntuacion
			@share_count = Plan.new.count_total_compartir
			
		end
		@difusiones_count = CampannaPublicitarium.new.cantidad_difusion_general
		
		@pregunta_frecuentes = PreguntaFrecuente.where(:estatus => 'A')

		if !@organizacion.blank?
				
			autenticacion = OrganizacionRedSocial.where("organizacion_id = ? AND provider = ?",@organizacion.id, "twitter").first
			@red_socials =  OrganizacionRedSocial.includes(:red_social).where("organizacion_id = ? ", @organizacion.id)
		end
			
		if autenticacion.blank?
			token = '72471749-c1rontqDpqjg5Xho2ZvQH4GWQOQNFMNOmqbjzYMEV'
			secret = 'El3vJnqM2fwb2GXQYgcGYbwq04ooJ4wAiIJAg514dGYrO'
		else
			token =  autenticacion.oauth_token
			secret = autenticacion.oauth_secret
		end
		
		@cliente_twitter = Twitter::REST::Client.new do |config|
		  config.consumer_key        = $consumer_key_twitter
		  config.consumer_secret     = $consumer_secret_twitter
		  config.access_token        = token
		  config.access_token_secret = secret
		end
			

		@interaccion_socials = @cliente_twitter.user_timeline(@cliente_twitter.user.screen_name)
		

		@comentarios = Interaccion.where("tipo_interaccion = ?", Interaccion.tipo_interaccions["comentario"]).order('created_at DESC').limit(4)
		

		@clientes = Usuario.all
	    render "organizacions/nosotros"
	end


	def contactar
		@organizacion_red_social = OrganizacionRedSocial.where("organizacion_id = ? ", @organizacion.id)
	    render "organizacions/contact"
	end


	private
    	def organizacion_edit_params
	      accessible = [ :nombre, :descripcion, :pais_id, :tipo_organizacion_id, :telefono, :email, :slogan, :direccion, :slogan, :mision, :vision, :logo, :formato_logo] # extend with your own params
	      params.require(:organizacion).permit(accessible)
    	end

end

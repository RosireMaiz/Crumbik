#require "base64"
#$IMAGEN_DEFAULT = "app/assets/images/producto.png";
class PublicidadsController < ApplicationController

	def new
		if !usuario_signed_in?
			redirect_to root_path
		else
			if !request.subdomain.present?
				organizacion = Organizacion.find_by(id: 0)
			else
				organizacion = Organizacion.find_by(subdominio: request.subdomain)
			end
			@publicidad = Publicidad.new
			formato_imagen = "data:image/png;base64,"
			imagen = Base64.encode64(File.open($IMAGEN_DEFAULT, "rb").read)
			@formato_imagen = formato_imagen
			@imagen = imagen
			@red_socials =  OrganizacionRedSocial.includes(:red_social).where("organizacion_id = ? ", organizacion.id)
			render "publicidads/new"
		end
	end

	def create
		publicidad = Publicidad.new(publicidad_params)
	    publicidad.save
	 	redirect_to :controller => 'publicidads', :action => 'consultar'
	end

	def consultar
		if !usuario_signed_in?
        	render "portal/index"
     	else
	   		@publicidads = Publicidad.order('id ASC').page(params[:page]).per(9)
	      	render "publicidads/publicidads"	
     	end
	end

	def edit
		if !usuario_signed_in?
			redirect_to root_path
		else
			
			id = params[:id_publicidad]
			@publicidad = Publicidad.where("id = ?", id).first	
			render "publicidads/edit"

		end
	end

	def save_edit
		id = params[:publicidad][:id]

		publicidad_edit = Publicidad.where(["id = ?", id]).first
		
		publicidad_edit.update(publicidad_params)

		redirect_to :controller => 'publicidads', :action => 'consultar'
	end

	def update_estatus
		id = params[:idpublicidad]
		estatus = params[:estatus]
		if Publicidad.update(id, :estatus => estatus)
			@publicidads = Publicidad.order('id ASC').page(params[:page]).per(9)
			puts @publicidads.length.to_s
			render :text =>'{ "success" : "true"}'
		else
			render :text => '{ "success" : "false"}'
		end
	end


	def eliminar
		id = params[:idpublicidad]
		publicidad = Publicidad.where(id: id).first
		publicidad.destroy
      if publicidad.destroyed?
      	@publicidads = Publicidad.order('id ASC').page(params[:page]).per(9)
      	render :text =>'{ "success" : "true"}'
	  else
		render :text => '{ "success" : "false"}'
	   end
	end

	def interaccion_social
		if !usuario_signed_in?
			redirect_to root_path
		else
			
			id = params[:id_publicidad]
			autenticacion = OrganizacionRedSocial.where("organizacion_id = ? AND provider = ?",@organizacion.id, "twitter").first
			@cliente_twitter = Twitter::REST::Client.new do |config|
			  config.consumer_key        = $consumer_key_twitter
			  config.consumer_secret     = $consumer_secret_twitter
			  config.access_token        = autenticacion.oauth_token
			  config.access_token_secret = autenticacion.oauth_secret
			end
			@red_socials =  OrganizacionRedSocial.includes(:red_social).where("organizacion_id = ? ", @organizacion.id)
			@interaccion_socials = InteraccionSocial.where("publicidad_id = ?", id).first
			@publicaciones = @interaccion_socials.publicacion_social
			#@username = @cliente_twitter.user.name
			
			#@count_tweets = @cliente_twitter.user.statuses_count 
			#@favorites_count = @cliente_twitter.user.favorites_count
			#@followers = @cliente_twitter.user.followers_count
			render "publicidads/interaccion_social_publicidad"

		end
	end

	private
	 def publicidad_params
      accessible = [ :formato_imagen, :imagen, :fecha_inicio , :fecha_finalizacion ] # extend with your own params
      params.require(:publicidad).permit(accessible)
    end
end

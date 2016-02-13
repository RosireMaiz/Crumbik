require "base64"
$IMAGEN_DEFAULT = "app/assets/images/producto.png";
class PublicidadsController < ApplicationController

	def new
		if !usuario_signed_in?
			redirect_to root_path
		else

			@publicidad = Publicidad.new
			formato_imagen = "data:image/png;base64,"
			imagen = Base64.encode64(File.open($IMAGEN_DEFAULT, "rb").read)
			@formato_imagen = formato_imagen
			@imagen = imagen
			@red_socials =  OrganizacionRedSocial.includes(:red_social).where("organizacion_id = ? ", @organizacion.id)
			render "publicidads/new"
		end
	end

	def create
		publicidad = Publicidad.new(publicidad_params)
	    publicidad.save

 		if params[:contenido_tweet].present?

 			contenido_tweet = params[:contenido_tweet]
		    url_tweet = params[:url_tweet]

	 		tweet = contenido_tweet.to_s + " " + url_tweet
	 		autenticacion = OrganizacionRedSocial.where("organizacion_id = ? AND provider = ?",@organizacion.id, "twitter").first
			client = Twitter::REST::Client.new do |config|
			  config.consumer_key        = $consumer_key_twitter
			  config.consumer_secret     = $consumer_secret_twitter
			  config.access_token        = autenticacion.oauth_token
			  config.access_token_secret = autenticacion.oauth_secret
			end
			interaccion_social = InteraccionSocial.new
		    interaccion_social.descripcion = contenido_tweet
		    interaccion_social.url = url_tweet
		    interaccion_social.organizacion_red_social_id = autenticacion.id
		    interaccion_social.publicidad_id = publicidad.id
		    interaccion_social.save

		    tweet_update = client.update(tweet)
		    publicacion = PublicacionSocial.new
		    publicacion.id_social = tweet_update.id.to_s
		    publicacion.interaccion_social_id = interaccion_social.id
		    publicacion.save

 		end
		
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
		puts "id " + id.to_s
		estatus = params[:estatus]
		if Publicidad.update(id, :estatus => estatus)
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
			@client = Twitter::REST::Client.new do |config|
			  config.consumer_key        = $consumer_key_twitter
			  config.consumer_secret     = $consumer_secret_twitter
			  config.access_token        = autenticacion.oauth_token
			  config.access_token_secret = autenticacion.oauth_secret
			end
			@interaccion_socials = InteraccionSocial.where("publicidad_id = ?", id)	
			render "publicidads/interaccion_social_publicidad"

		end
	end

	private
	 def publicidad_params
      accessible = [ :descripcion, :producto_id, :fecha_inicio , :fecha_finalizacion ] # extend with your own params
      params.require(:publicidad).permit(accessible)
    end
end

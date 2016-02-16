class InteraccionSocialsController < ApplicationController

	def consuta_interaccion_socials
		if !usuario_signed_in?
			redirect_to root_path
		else
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
			

			@interaccion_socials = @cliente_twitter.user_timeline("Rosiire")
			render "interaccion_socials/interaccion_socials"

		end
	end

end

class InteraccionSocialsController < ApplicationController

	def consuta_interaccion_socials
		if !usuario_signed_in?
			redirect_to root_path
		else
			autenticacion = OrganizacionRedSocial.where("organizacion_id = ? AND provider = ?",@organizacion.id, "twitter").first
			@cliente_twitter = Twitter::REST::Client.new do |config|
			  config.consumer_key        = $consumer_key_twitter
			  config.consumer_secret     = $consumer_secret_twitter
			  config.access_token        = autenticacion.oauth_token
			  config.access_token_secret = autenticacion.oauth_secret
			end
			@red_socials =  OrganizacionRedSocial.includes(:red_social).where("organizacion_id = ? ", @organizacion.id)
			@interaccion_socials = @cliente_twitter.user_timeline("Rosiire")
			render "interaccion_socials/interaccion_socials"

		end
	end

end

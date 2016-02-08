class UsuarioRedSocial < ActiveRecord::Base

	belongs_to :usuario
  	belongs_to :red_social

  	def self.find_for_oauth(auth, idRedSocial, current_usuario)
  		usuario = current_usuario
    	usuario_red_social = UsuarioRedSocial.find_by(uid: auth.uid, provider: auth.provider)
    	provider = auth.provider

		if usuario_red_social.blank?
			usuario_red_social = UsuarioRedSocial.new
			usuario_red_social.uid = auth.uid
			usuario_red_social.provider = auth.provider
			usuario_red_social.red_social_id = idRedSocial
			usuario_red_social.usuario_id = usuario.id		
		end

		usuario_red_social.oauth_token = auth.credentials.token
		usuario_red_social.oauth_secret = auth.credentials.secret
		
		if auth.credentials.expires
			usuario_red_social.oauth_expires_at  = Time.at(auth.credentials.expires_at)
		end

		if provider == "twitter"
			usuario_red_social.url = auth.info.urls.Twitter
		end

		if provider == "facebook"
			usuario_red_social.url = auth.info.urls.Facebook
		end

		if provider == "google_oauth2"
			usuario_red_social.url = auth.extra.raw_info.profile
		end

		if provider == "github"
			usuario_red_social.url = auth.info.urls.GitHub
		end

		if provider == "linkedin"
			usuario_red_social.url = auth.info.urls.public_profile
		end

		if provider == "instagram"
			usuario_red_social.url ="https://www.instagram.com/" + auth.info.nickname 
		end

		usuario_red_social.save
		usuario_red_social
  	end
  	
end
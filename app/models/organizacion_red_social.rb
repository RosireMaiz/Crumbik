class OrganizacionRedSocial < ActiveRecord::Base
	
	belongs_to :organizacion
  	belongs_to :red_social

  	def self.find_for_oauth(auth, idRedSocial, subdominio)
  		organizacion = Organizacion.where(["subdominio = ?", subdominio]).first
    	organizacion_red_social = OrganizacionRedSocial.find_by(uid: auth.uid, provider: auth.provider)
    	provider = auth.provider

		if organizacion_red_social.blank?
			organizacion_red_social = OrganizacionRedSocial.new
			organizacion_red_social.uid = auth.uid
			organizacion_red_social.provider = auth.provider
			organizacion_red_social.red_social_id = idRedSocial
			organizacion_red_social.organizacion_id = organizacion.id		
		end

		organizacion_red_social.oauth_token = auth.credentials.token
		organizacion_red_social.oauth_secret = auth.credentials.secret

		if auth.credentials.expires
			organizacion_red_social.oauth_expires_at  = Time.at(auth.credentials.expires_at)
		end
		

		if provider == "twitter"
			organizacion_red_social.url = auth.info.urls.Twitter
		end

		if provider == "facebook"
			organizacion_red_social.url = auth.info.urls.Facebook
		end

		if provider == "google_oauth2"
			organizacion_red_social.url = auth.extra.raw_info.profile
		end

		if provider == "github"
			organizacion_red_social.url = auth.info.urls.GitHub
		end

		if provider == "linkedin"
			organizacion_red_social.url = auth.info.urls.public_profile
		end

		if provider == "instagram"
			organizacion_red_social.url ="https://www.instagram.com/" + auth.info.nickname 
		end

		organizacion_red_social.save
		organizacion_red_social
  	end

end

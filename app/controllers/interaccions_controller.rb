class InteraccionsController < ApplicationController
	
	def consultar
		if !usuario_signed_in?
			redirect_to root_path
		else
			if !request.subdomain.present?
				@comentarios_count = Plan.new.count_total_comentarios
				@like_count = Plan.new.count_total_me_gusta
				@average_count = Plan.new.average_puntuacion
				@share_count = Plan.new.count_total_compartir

			else

				@comentarios_count = Producto.new.count_total_comentarios
				@like_count = Producto.new.count_total_me_gusta
				@average_count = Producto.new.average_puntuacion
				@share_count = Producto.new.count_total_compartir
				
			end
			@difusiones_count = CampannaPublicitarium.new.cantidad_difusion_general
			render "interaccions/interaccions_general"
		end
	end

	def consultar_producto
		if !usuario_signed_in?
			redirect_to root_path
		else
			id_producto = params[:id_producto]
			@producto = Producto.where(id: id_producto).first
			@comentarios_count = Producto.new.count_total_comentarios_producto(id_producto)
			@like_count = Producto.new.count_total_me_gusta_producto(id_producto)
			@average_count = Producto.new.average_puntuacion_producto(id_producto)
			@share_count = Producto.new.count_total_compartir_producto(id_producto)
			@difusiones_count = CampannaPublicitarium.new.cantidad_difusion_producto(id_producto)
			render "interaccions/interaccions_general"
		end
	end

	def consultar_plan
		if !usuario_signed_in?
			redirect_to root_path
		else
			id_plan = params[:idplan]
			@plan = Plan.where(id: id_plan).first
			@comentarios_count = Plan.new.count_total_comentarios_producto(id_plan)
			@like_count = Plan.new.count_total_me_gusta_producto(id_plan)
			@average_count = Plan.new.average_puntuacion_producto(id_plan)
			@share_count = Plan.new.count_total_compartir_producto(id_plan)
			@difusiones_count = CampannaPublicitarium.new.cantidad_difusion_producto(id_plan)
			render "interaccions/interaccions_general"
		end
	end

	def consuta_interaccion_socials
		if !usuario_signed_in?
			redirect_to root_path
		else
			
			if !@organizacion.blank?
				
				autenticacion_twitter = OrganizacionRedSocial.where("organizacion_id = ? AND provider = ?",@organizacion.id, "twitter").first
				@red_socials =  OrganizacionRedSocial.includes(:red_social).where("organizacion_id = ? AND red_social_id IN (SELECT id FROM red_socials WHERE difusion = ?)", @organizacion.id, true)
			end

			@red_socials.each do |red_social_organizacion|
				if red_social_organizacion.red_social.nombre == "Twitter"
					if red_social_organizacion.blank?
						token = '72471749-c1rontqDpqjg5Xho2ZvQH4GWQOQNFMNOmqbjzYMEV'
						secret = 'El3vJnqM2fwb2GXQYgcGYbwq04ooJ4wAiIJAg514dGYrO'
					else
						token =  red_social_organizacion.oauth_token
						secret = red_social_organizacion.oauth_secret
					end

					@cliente_twitter = Twitter::REST::Client.new do |config|
					  config.consumer_key        = $consumer_key_twitter
					  config.consumer_secret     = $consumer_secret_twitter
					  config.access_token        = token
					  config.access_token_secret = secret
					end

					@interaccion_socials = @cliente_twitter.user_timeline(@cliente_twitter.user.screen_name)

				elsif red_social_organizacion.red_social.nombre == "Facebook"
					@facebook_cliente = FbGraph::User.me(red_social_organizacion.oauth_token).fetch
					@interaccion_socials_facebook = @facebook_cliente.posts
					@friends= @facebook_cliente.friend_lists
					@likes = @facebook_cliente.likes
				end

			end
			render "interaccions/interaccions_social"
		end
	end

	def consultar_campanna_social
		if !usuario_signed_in?
			redirect_to root_path
		else
			@sms_count = CampannaPublicitarium.new.count_sms
			@llamada_count = CampannaPublicitarium.new.count_llamada
			@email_count = CampannaPublicitarium.new.count_email
			@social_count = CampannaPublicitarium.new.count_red_social				
			render "interaccions/interaccions_campannas"
		end
	end

	def consultar_campanna_social_producto
		if !usuario_signed_in?
			redirect_to root_path
		else
			id_producto = params[:id_producto]
			@producto = Producto.where(id: id_producto).first
			@sms_count = CampannaPublicitarium.new.count_sms_producto(id_producto)
			@llamada_count = CampannaPublicitarium.new.count_llamada_producto(id_producto)
			@email_count = CampannaPublicitarium.new.count_email_producto(id_producto)
			@social_count = CampannaPublicitarium.new.count_red_social_producto(id_producto)			
			render "interaccions/interaccions_campannas"
		end
	end

	def consultar_campanna_social_plan
		if !usuario_signed_in?
			redirect_to root_path
		else
			id_plan = params[:idplan]
			@plan = Plan.where(id: id_plan).first
			@sms_count = CampannaPublicitarium.new.count_sms_producto(id_plan)
			@llamada_count = CampannaPublicitarium.new.count_llamada_producto(id_plan)
			@email_count = CampannaPublicitarium.new.count_email_producto(id_plan)
			@social_count = CampannaPublicitarium.new.count_red_social_producto(id_plan)				
			render "interaccions/interaccions_campannas"
		end
	end
end

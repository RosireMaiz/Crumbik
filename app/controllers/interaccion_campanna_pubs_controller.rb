class InteraccionCampannaPubsController < ApplicationController

	def index
		@usuarios = Usuario.all
	end

	def new_difusion
		if !usuario_signed_in?
			redirect_to root_path
		else
			id = params[:id_campanna_publicitaria]
			@campanna_publicitaria = CampannaPublicitarium.where("id = ?", id).first	
			@medio_difusions = @campanna_publicitaria.campanna_publicitaria_detalles.pluck(:medio_difusion)
			id_usuarios = Usuario.order('id ASC').pluck(:id)
			id_filtrado ||= Array.new
			
			@campanna_publicitaria.criterio_campanna_pubs.each do |criterio|
				operador_parametro = criterio.operador
				valor_parametro = criterio.valor
				campo_seleccion = criterio.criterio_difusion.campo_seleccion
				tabla = criterio.criterio_difusion.tabla
				campo_comparacion = criterio.criterio_difusion.campo_comparacion.split("#")[0]
				if criterio.criterio_difusion.tipo_consulta == "subconsulta"
					sql = "Select " +  campo_seleccion.to_s + " from " + tabla.to_s + " where " + campo_comparacion.to_s + operador_parametro.to_s + " '" + valor_parametro.to_s + "' )"	
				else
					sql = "Select " +  campo_seleccion.to_s + " from " + tabla.to_s + " where " + campo_comparacion.to_s + operador_parametro.to_s + " '" + valor_parametro.to_s + "'"
				end

				if campo_comparacion.to_s['('] && !campo_comparacion.to_s[")"]
					sql = sql + ")"
				end
				
				records_array = ActiveRecord::Base.connection.execute(sql)
	     		id_criterio ||= Array.new

	     		records_array.each do |row|
					id_criterio.push(row[0])
				end

				id_filtrado = id_usuarios & id_criterio
				id_usuarios = id_filtrado
			end

			#criterio = @campanna_publicitaria.criterio_campanna_pubs.first

			

			@usuarios = Usuario.where(:id => id_filtrado)
				

			if !request.subdomain.present?
				organizacion = Organizacion.find_by(id: 0)
			else
				organizacion = Organizacion.find_by(subdominio: request.subdomain)
			end
         	@redes_sociales = OrganizacionRedSocial.includes(:red_social).where(["red_social_id in (?) ",  RedSocial.select(:id).where("difusion = ? ", 1)]).where(["organizacion_id = ?", organizacion.id])
         	@red_socials = RedSocial.where(["difusion = ?", true])
			
		end
	end

	def red_social
		red_social_ids = params[:red_social_ids]
		mensaje = params[:mensaje]
		url = params[:url]
		id_campanna_publicitaria = params[:id_campanna_publicitaria]
		

		if !request.subdomain.present?
			organizacion = Organizacion.find_by(id: 0)
		else
			organizacion = Organizacion.find_by(subdominio: request.subdomain)
		end
		campanna_publicitaria_detalle = CampannaPublicitariaDetalle.where("campanna_publicitaria_id = ? AND medio_difusion = ?", id_campanna_publicitaria, CampannaPublicitariaDetalle.medio_difusions["red_social"] ).first
		
		interacion_campanna_publicitaria = InteraccionCampannaPub.new
		interacion_campanna_publicitaria.contenido = mensaje
		interacion_campanna_publicitaria.url = url
		interacion_campanna_publicitaria.campanna_detalle_id = campanna_publicitaria_detalle.id
		interacion_campanna_publicitaria.usuario_ejercutivo_id = current_usuario.id
		interacion_campanna_publicitaria.save

		red_social_ids.each do |red_social_id|
			
			id = red_social_id
			red_social_organizacion = OrganizacionRedSocial.includes(:red_social).find_by(id: id)
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
				tweet = mensaje.to_s + " " + url.to_s

				tweet_update = @cliente_twitter.update(tweet)
			    interacion_campanna_social = InteraccionCampannaSocial.new
			    interacion_campanna_social.social_id = tweet_update.id.to_s
			    interacion_campanna_social.organizacion_red_socials_id = red_social_organizacion.id
			    interacion_campanna_social.interaccion_campanna_id = interacion_campanna_publicitaria.id
			    interacion_campanna_social.save

			elsif red_social_organizacion.red_social.nombre == "Facebook"
				
				facebook_cliente = FbGraph::User.me(red_social_organizacion.oauth_token)
				facebook_update= facebook_cliente.feed!(
					:message => mensaje.to_s,
					:picture => '',
					:link => url.to_s,
					:name => organizacion.nombre,
					:description => mensaje.to_s
				)

			    interacion_campanna_social = InteraccionCampannaSocial.new
			    interacion_campanna_social.social_id = facebook_update.identifier.to_s
			    interacion_campanna_social.organizacion_red_socials_id = red_social_organizacion.id
			    interacion_campanna_social.interaccion_campanna_id = interacion_campanna_publicitaria.id
			    interacion_campanna_social.save
			    
			end
		end

       	@redes_sociales = OrganizacionRedSocial.includes(:red_social).where(["red_social_id in (?) ",  RedSocial.select(:id).where("difusion = ? ", 1)]).where(["organizacion_id = ?", organizacion.id])
       	@red_socials = RedSocial.where(["difusion = ?", true])

		render :text =>'{ "success" : "true"}'
	end

	def sms
		usuarios_mensaje_ids = params[:usuarios_mensaje_ids]
		mensaje = params[:mensaje]
		id_campanna_publicitaria = params[:id_campanna_publicitaria]
		

		if !request.subdomain.present?
			organizacion = Organizacion.find_by(id: 0)
		else
			organizacion = Organizacion.find_by(subdominio: request.subdomain)
		end
		campanna_publicitaria_detalle = CampannaPublicitariaDetalle.where("campanna_publicitaria_id = ? AND medio_difusion = ?", id_campanna_publicitaria, CampannaPublicitariaDetalle.medio_difusions["sms"] ).first
		
		interacion_campanna_publicitaria = InteraccionCampannaPub.new
		interacion_campanna_publicitaria.contenido = mensaje
		interacion_campanna_publicitaria.campanna_detalle_id = campanna_publicitaria_detalle.id
		interacion_campanna_publicitaria.usuario_ejercutivo_id = current_usuario.id
		interacion_campanna_publicitaria.save

		usuarios_mensaje_ids.each do |usuario_id|
			id = usuario_id
			usuario = Usuario.find_by(id: id)
			phone_number = '+'+usuario.pais.codigo_telefono.to_s+usuario.perfil.telefono_movil.to_s
			#phone_number = '+584245922845'


			send_message(phone_number, mensaje)

			interacion_campanna_usuario = InteraccionCampannaUsuario.new
		    interacion_campanna_usuario.usuario_id = id
		    interacion_campanna_usuario.telefono_movil = phone_number
		    interacion_campanna_usuario.interaccion_campanna_id = interacion_campanna_publicitaria.id
		    interacion_campanna_usuario.save
		end
        
        @usuarios = Usuario.order('id ASC')

		render :text =>'{ "success" : "true"}'
	end

	def send_message(phone_number, message)

		@client = Twilio::REST::Client.new($account_sid, $auth_token)

	    @account = @client.account
	   
	    @message = @account.sms.messages.create({
	                    :from => $twilio_number,
	                    :to => phone_number,
	                    :body => message })
    end

    def email
		usuarios_email_ids = params[:usuarios_email_ids]
		mensaje = params[:mensaje]
		asunto = params[:asunto]
		id_campanna_publicitaria = params[:id_campanna_publicitaria]
		

		if !request.subdomain.present?
			organizacion = Organizacion.find_by(id: 0)
		else
			organizacion = Organizacion.find_by(subdominio: request.subdomain)
		end
		campanna_publicitaria_detalle = CampannaPublicitariaDetalle.where("campanna_publicitaria_id = ? AND medio_difusion = ?", id_campanna_publicitaria, CampannaPublicitariaDetalle.medio_difusions["sms"] ).first
		
		interacion_campanna_publicitaria = InteraccionCampannaPub.new
		interacion_campanna_publicitaria.contenido = mensaje
		interacion_campanna_publicitaria.asunto = asunto
		interacion_campanna_publicitaria.campanna_detalle_id = campanna_publicitaria_detalle.id
		interacion_campanna_publicitaria.usuario_ejercutivo_id = current_usuario.id
		interacion_campanna_publicitaria.save

		usuarios_email_ids.each do |usuario_id|
			id = usuario_id
			usuario = Usuario.find_by(id: id)
			CampannaPublicitariaMailer.email_difusion(asunto, mensaje, usuario.email).deliver
			interacion_campanna_usuario = InteraccionCampannaUsuario.new
		    interacion_campanna_usuario.usuario_id = id
		    interacion_campanna_usuario.email = usuario.email
		    interacion_campanna_usuario.interaccion_campanna_id = interacion_campanna_publicitaria.id
		    interacion_campanna_usuario.save
		end
        
        @usuarios = Usuario.order('id ASC')

		render :text =>'{ "success" : "true"}'
	end
end

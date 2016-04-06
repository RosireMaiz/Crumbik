class CampannaPublicitariasController < ApplicationController

	$ICONOS_DIFUSION = ["mdi-notification-phone-in-talk", "fa fa-comments", "mdi-communication-email", "mdi-social-share"];
	def dashboard_campanna
		if !usuario_signed_in?
        	redirect_to root_path
     	else
	        @campanna_publicitarias = CampannaPublicitarium.order('id ASC').page(params[:page]).per(9)
	        @campanna_publicitarias_ejecucion = CampannaPublicitarium.where(["? between fecha_inicio  AND fecha_fin  ", Date.today]).order('id ASC').page(params[:page]).per(9)
	        @campanna_publicitarias_proximas = CampannaPublicitarium.where([" fecha_inicio > ? ", Date.today]).order('id ASC').page(params[:page]).per(9)
	        @campanna_publicitarias_ejecutadas = CampannaPublicitarium.where([" fecha_fin < ? ", Date.today]).order('id ASC').page(params[:page]).per(9)
	        render "campanna_publicitarias/campanna_publicitarias"	
     	end
	end

	def new
		if !usuario_signed_in?
			redirect_to root_path
		else
			@campanna_publicitaria = CampannaPublicitarium.new
			render "campanna_publicitarias/new"
		end
	end

	def create
		@campanna_publicitaria = CampannaPublicitarium.new(campanna_params)
		@campanna_publicitaria.save
		redirect_to :controller => 'campanna_publicitarias', :action => 'dashboard_campanna'
	end

	def show
		if !usuario_signed_in?
			redirect_to root_path
		else
			id = params[:id_campanna_publicitaria]
			@campanna_publicitaria = CampannaPublicitarium.where("id = ?", id).first	
			require 'date'
			date_range = @campanna_publicitaria.fecha_inicio..@campanna_publicitaria.fecha_fin

			date_months = date_range.map {|d| Date.new(d.year, d.month, 1) }.uniq
			@months = date_months.map {|d| d.strftime "%B-%Y" }

			@sms_count = @campanna_publicitaria.count_sms_unique
			@llamada_count = @campanna_publicitaria.count_llamada_unique
			@email_count = @campanna_publicitaria.count_email_unique
			@social_count = @campanna_publicitaria.count_red_social_unique

			@cantidad = @months.size
			render "campanna_publicitarias/show"
		end
	end
	
	def edit
		if !usuario_signed_in?
			redirect_to root_path
		else
			id = params[:id_campanna_publicitaria]
			@campanna_publicitaria = CampannaPublicitarium.where("id = ?", id).first	
			render "campanna_publicitarias/edit"
		end
	end

	def eliminar
		id = params[:id_campanna_publicitaria]
		campanna_publicitaria = CampannaPublicitarium.where(id: id).first
		
		detalles = campanna_publicitaria.campanna_publicitaria_detalles
		if ! detalles.nil?
			detalles.each do |detalle|
				detalle.destroy
			end
		end
		
		campanna_publicitaria.destroy
      if campanna_publicitaria.destroyed?
      	render :text =>'{ "success" : "true"}'
	  else
		render :text => '{ "success" : "false"}'
	   end
	end

	def save_edit
		id = params[:campanna_publicitarium][:id]

		campanna_publicitaria_edit = CampannaPublicitarium.where(["id = ?", id]).first
		
		campanna_publicitaria_edit.update(campanna_edit_params)

		redirect_to :controller => 'campanna_publicitarias', :action => 'dashboard_campanna'
	end

	def show_email
		if !usuario_signed_in?
			redirect_to root_path
		else
			id = params[:id_campanna_publicitaria]
			@campanna_publicitaria_detalle = CampannaPublicitariaDetalle.where("campanna_publicitaria_id = ? AND medio_difusion = ?", id, CampannaPublicitariaDetalle.medio_difusions["email"]).first	
			render "campanna_publicitarias/show_email"
		end
	end

	def show_sms
		if !usuario_signed_in?
			redirect_to root_path
		else
			id = params[:id_campanna_publicitaria]
			@campanna_publicitaria_detalle = CampannaPublicitariaDetalle.where("campanna_publicitaria_id = ? AND medio_difusion = ?", id, CampannaPublicitariaDetalle.medio_difusions["sms"]).first	
			render "campanna_publicitarias/show_sms"
		end
	end


	def show_red_social
		if !usuario_signed_in?
			redirect_to root_path
		else
			id = params[:id_campanna_publicitaria]
			@campanna_publicitaria_detalle = CampannaPublicitariaDetalle.where("campanna_publicitaria_id = ? AND medio_difusion = ?", id, CampannaPublicitariaDetalle.medio_difusions["red_social"]).first	

			if !@organizacion.blank?
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

					
					@interaccion_socials ||= Array.new

					@campanna_publicitaria_detalle.interaccion_campanna_pub.each do |interaccion|
						interaccion.interaccion_campanna_social.each do |intteraccion_social|
							if intteraccion_social.organizacion_red_socials_id	== red_social_organizacion.id
								interaccion_tw = @cliente_twitter.status(intteraccion_social.social_id.to_i)
								@interaccion_socials.push(interaccion_tw)
							end
						end
					end

				elsif red_social_organizacion.red_social.nombre == "Facebook"
					@facebook_cliente = FbGraph::User.me(red_social_organizacion.oauth_token).fetch
					@facebook_cliente = FbGraph::User.me(red_social_organizacion.oauth_token).fetch
					@interaccion_socials_facebook = @facebook_cliente.posts
					
				end

			end


			render "campanna_publicitarias/show_red_social"
		end
	end


	def show_llamada
		if !usuario_signed_in?
			redirect_to root_path
		else
			id = params[:id_campanna_publicitaria]
			@campanna_publicitaria_detalle = CampannaPublicitariaDetalle.where("campanna_publicitaria_id = ? AND medio_difusion = ?", id, CampannaPublicitariaDetalle.medio_difusions["llamada"]).first	
			render "campanna_publicitarias/show_llamada"
		end
	end

	private
	   	def campanna_params
	    accessible = [ :titulo, :descripcion, :fecha_inicio, :fecha_fin, :producto_id, 	:campanna_publicitaria_detalles_attributes =>[[ :medio_difusion]], :criterio_campanna_pubs_attributes =>[ [ :criterio_difusion_id, :operador, :valor ] ] ] # extend with your own params
	    params.require(:campanna_publicitarium).permit(accessible)
		end
		def campanna_edit_params
	    	accessible = [ :titulo, :descripcion, :fecha_inicio, :fecha_fin, :producto_id ] # extend with your own params
	    	params.require(:campanna_publicitarium).permit(accessible)
		end
end

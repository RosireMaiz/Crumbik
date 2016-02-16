class ActividadPublicitariaController < ApplicationController
	
	def new
		if !usuario_signed_in?
			redirect_to root_path
		else

			@actividad_publicitaria = ActividadPublicitarium.new
			@formato_imagen = "data:image/png;base64,"
			@imagen = Base64.encode64(File.open($IMAGEN_DEFAULT, "rb").read)
			@red_socials =  ActividadPublicitariaDetalle.type_actividads["sms"]

			render "actividad_publicitaria/new"
		end
	end

	def create
		actividad_publicitaria = ActividadPublicitarium.new(actividad_publicitaria_params)
	    
	    actividad_publicitaria.save

 		if !params[:contenido_sms].blank?
 			contenido_sms = params[:contenido_sms]
 			url_sms = params[:url_sms]
 			contenido = contenido_sms.to_s + " " + url_sms.to_s
			actividad_publicitaria_detalle = ActividadPublicitariaDetalle.new
		    actividad_publicitaria_detalle.contenido = contenido_sms
		    actividad_publicitaria_detalle.type_actividad = ActividadPublicitariaDetalle.type_actividads[:sms]
		    actividad_publicitaria_detalle.campanna_id = actividad_publicitaria.id
		    actividad_publicitaria_detalle.save
 		end
		if !params[:asunto_llamada].blank?
 			asunto_llamada = params[:asunto_llamada]
			actividad_publicitaria_detalle = ActividadPublicitariaDetalle.new
		    actividad_publicitaria_detalle.contenido = asunto_llamada.to_s
		    actividad_publicitaria_detalle.type_actividad = ActividadPublicitariaDetalle.type_actividads[:llamada]
		    actividad_publicitaria_detalle.campanna_id = actividad_publicitaria.id
		    actividad_publicitaria_detalle.save
 		end

 		if !params[:contenido_email].blank?
 			contenido_email = params[:contenido_email]
	 		asunto_email = params[:asunto_email]
	 		contenido =  asunto_email.to_s + "*e*e*u*" + contenido_email.to_s
			actividad_publicitaria_detalle = ActividadPublicitariaDetalle.new
		    actividad_publicitaria_detalle.contenido = contenido
		    actividad_publicitaria_detalle.type_actividad = ActividadPublicitariaDetalle.type_actividads[:email]
		    actividad_publicitaria_detalle.campanna_id = actividad_publicitaria.id
		    actividad_publicitaria_detalle.save
 		end
	 	redirect_to :controller => 'actividad_publicitaria', :action => 'consultar'
	end
	
	def consultar
		if !usuario_signed_in?
        	render "portal/index"
     	else

	        @actividad_publicitarias = ActividadPublicitarium.order('id ASC')
	        render "actividad_publicitaria/actividad_publicitarias"	
     	end
	end

	def actividad_publicitarias_sms
		if !usuario_signed_in?
        	render "portal/index"
     	else
	        @actividad_publicitaria_detalle = ActividadPublicitariaDetalle.where(type_actividad: ActividadPublicitariaDetalle.type_actividads[:sms]).order('id ASC')
	        render "actividad_publicitaria/actividad_publicitarias_sms"	
     	end
	end

	def actividad_publicitarias_llamadas
		if !usuario_signed_in?
        	render "portal/index"
     	else
	        @actividad_publicitaria_detalle = ActividadPublicitariaDetalle.where(type_actividad: ActividadPublicitariaDetalle.type_actividads[:llamada]).order('id ASC')
	        render "actividad_publicitaria/actividad_publicitarias_llamadas"	
     	end
	end

	def actividad_publicitarias_llamadas_clientes
		if !usuario_signed_in?
        	render "portal/index"
     	else
	        @actividad_publicitaria_detalle = ActividadPublicitariaDetalle.where(id: params[:id]).first
	        @clientes = Cliente.order('id ASC')
	        render "actividad_publicitaria/actividad_publicitarias_llamadas_clientes"	
     	end
	end

	def llamada
		if !usuario_signed_in?
        	render "portal/index"
     	else
	        render "actividad_publicitaria/llamada"	
     	end
	end

	def actividad_publicitarias_email
		if !usuario_signed_in?
        	render "portal/index"
     	else
	        @actividad_publicitaria_detalle = ActividadPublicitariaDetalle.where(type_actividad: ActividadPublicitariaDetalle.type_actividads[:email]).order('id ASC')
	        render "actividad_publicitaria/actividad_publicitarias_email"	
     	end
	end

	def eliminar
		id = params[:actividad_publicitaria_id]
		actividad_publicitaria = ActividadPublicitarium.where(id: id).first
		actividad_publicitaria.destroy
      if actividad_publicitaria.destroyed?
      	render :text =>'{ "success" : "true"}'
	  else
		render :text => '{ "success" : "false"}'
	   end
	end

	def enviar_sms
		if !usuario_signed_in?
        	render "portal/index"
     	else
     		@actividad_publicitaria_detalle = ActividadPublicitariaDetalle.where(id: params[:id]).first
     		@clientes = Cliente.order('id ASC')
	        render "actividad_publicitaria/sms"	
     	end
	end

	def enviar_email
		if !usuario_signed_in?
        	render "portal/index"
     	else
     		@actividad_publicitaria_detalle = ActividadPublicitariaDetalle.where(id: params[:id]).first
     		@clientes = Cliente.order('id ASC')
	        render "actividad_publicitaria/email"	
     	end
	end

	private
	 def actividad_publicitaria_params
      accessible = [ :titulo, :descripcion, :producto_id, :inicio , :fin ] # extend with your own params
      params.require(:actividad_publicitarium).permit(accessible)
    end
end

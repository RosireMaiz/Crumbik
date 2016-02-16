class ActividadPublicitariaController < ApplicationController
	
	def new
		if !usuario_signed_in?
			redirect_to root_path
		else

			@actividad_publicitaria = Publicidad.new
			@formato_imagen = "data:image/png;base64,"
			@imagen = Base64.encode64(File.open($IMAGEN_DEFAULT, "rb").read)
			@red_socials = - ActividadPublicitariaDetalles.type_actividades
			render "actividad_publicitaria/new"
		end
	end

	def create
		actividad_publicitaria = ActividadPublicitarium.new(actividad_publicitaria_params)
	    actividad_publicitaria.save

 		if !params[:contenido_sms].blank?
 			contenido_sms = params[:contenido_sms]
	 		sms = contenido_sms.to_s 
			actividad_publicitaria_detalle = ActividadPublicitariaDetalles.new
		    actividad_publicitaria_detalle.contenido = contenido_sms
		    actividad_publicitaria_detalle.type_actividad = ActividadPublicitariaDetalles.type_actividad[:sms]
		    actividad_publicitaria_detalle.actividad_publicitaria_id = actividad_publicitaria.id
		    actividad_publicitaria_detalle.save
 		end
		
	 	redirect_to :controller => 'publicidads', :action => 'consultar'
	end
	
	def consultar
		if !usuario_signed_in?
        	render "portal/index"
     	else

	        @actividad_publicitarias = ActividadPublicitarium.order('id ASC')
	        render "actividad_publicitaria/actividad_publicitarias"	
     	end
	end

	

	def update_estatus

		id = params[:actividad_publicitaria_id]
		puts "id " + id.to_s
		estatus = params[:estatus]
		if ActividadPublicitarium.update(id, :estatus => estatus)
			render :text =>'{ "success" : "true"}'
		else
			render :text => '{ "success" : "false"}'
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



	private
	 def actividad_publicitaria_params
      accessible = [ :descripcion, :producto_id, :inicio , :fin ] # extend with your own params
      params.require(:actividad_publicitarium).permit(accessible)
    end
end

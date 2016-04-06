class PreguntaFrecuentesController < ApplicationController
	def validar_pregunta_frecuente
	    if PreguntaFrecuente.exists?(pregunta: params[:pregunta_frecuente][:pregunta])
	    	render json: false
	    else
	    	render json: true
	    end
  	end

	def validar_pregunta_frecuente_update
	    if PreguntaFrecuente.exists?(  ["pregunta = ? AND  id <> ? ", params[:pregunta_frecuente][:pregunta], params[:idpregunta] ])  
	    	render json: false
	    else
	    	render json: true
	    end
  	end

	def new
		if !usuario_signed_in?
			redirect_to root_path
		else
			@pregunta_frecuente = PreguntaFrecuente.new
			
			render "pregunta_frecuentes/new"
		end
	end

	def create
		@pregunta_frecuente = PreguntaFrecuente.new(pregunta_frecuente_params)
	    @pregunta_frecuente.save
	  	redirect_to :controller => 'pregunta_frecuentes', :action => 'consultar'
	end

	def consultar
		if !usuario_signed_in?
        	render "portal/index"
     	else

	        
	           @pregunta_frecuentes = PreguntaFrecuente.order('id ASC')
	           @valor = true;
	           render "pregunta_frecuentes/pregunta_frecuentes"	
         
     	end
	end
	
	def update_estatus
		id = params[:idpregunta]
		estatus = params[:estatus]
		if PreguntaFrecuente.update(id, :estatus => estatus)
			render :text =>'{ "success" : "true"}'
		else
			render :text => '{ "success" : "false"}'
		end
	end

	def update
		id = params[:idpregunta]
		pregunta = params[:pregunta]
		respuesta = params[:respuesta]
		if PreguntaFrecuente.update(id, :pregunta => pregunta, :respuesta => respuesta)
			render :text =>'{ "success" : "true"}'
		else

			render :text => '{ "success" : "false"}'
		end
	end

	def eliminar
		id = params[:idpregunta]
		pregunta_frecuente = PreguntaFrecuente.where(id: id).first
		pregunta_frecuente.destroy
      if pregunta_frecuente.destroyed?
      	render :text =>'{ "success" : "true"}'
	  else
		render :text => '{ "success" : "false"}'
	   end
	end

	def consultar_pregunta_frecuente
		id = params[:idpregunta]
		@pregunta_frecuente = PreguntaFrecuente.where(id: id).first
		render :json => @pregunta_frecuente
	end


	def preguntas
		@pregunta_frecuentes = PreguntaFrecuente.where(:estatus => 'A')
		render "pregunta_frecuentes/list"
	end	


	private
		def pregunta_frecuente_params
	      accessible = [ :pregunta, :respuesta ] # extend with your own params
	      params.require(:pregunta_frecuente).permit(accessible)
	    end

end

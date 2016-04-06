require "base64"
class PlansController < ApplicationController
	def validar_plan
	    if Plan.exists?(nombre: params[:plan][:nombre])
	    	render json: false
	    else
	    	render json: true
	    end
  	end

  	def validar_plan_update
	    if Plan.exists?( [ "nombre = ? AND  id <> ? ", params[:plan][:nombre], params[:idplan] ])  
	    	render json: false
	    else
	    	render json: true
	    end
  	end

  	def new
		if !usuario_signed_in?
			redirect_to root_path
		else

			if request.subdomain.present?
				redirect_to root_path
			else
				formato_imagen = "data:image/jpg;base64,"
	    		imagen_plan = Base64.encode64(File.open($IMAGEN_DEFAULT, "rb").read)
				@plan = Plan.new
				@plan.attributes  = {:imagen => imagen_plan, :formato_imagen => formato_imagen}
				render "plans/new"
			end
		end
	end

	def edit
		if !usuario_signed_in?
			redirect_to root_path
		else
			@plan = Plan.new
			if request.subdomain.present?
				redirect_to root_path
			else
				id = params[:id_plan]
				@plan = Plan.where("id = ?", id).first
				render "plans/edit"
			end
		end
	end

	def save_edit
		id = params[:plan_id]

		plan_edit = Plan.where(["id = ?", id]).first
		plan_edit.update(plan_params)

		plan_servicios = plan_edit.plan_servicio
		if ! plan_servicios.nil?
			plan_servicios.each do |plan_servicio|
				plan_servicio.destroy
			end
		end

		servicios = params[:plan_servicio][:servicio_ids]

		descripciones = params[:plan_servicio][:descripcion]

		plan_id = plan_edit.id
		if ! servicios.nil?
			servicios.each do |servicio|
			 	servicio_id = servicio
			 	descripcion = descripciones[servicio.to_i-1]
			 	@plan_servicio = PlanServicio.new
			 	@plan_servicio.servicio_id = servicio_id
			 	@plan_servicio.plan_id = plan_id
				@plan_servicio.descripcion = descripcion
				@plan_servicio.save
			end
		end
		
		redirect_to :controller => 'plans', :action => 'consultar'

	end
	
	def create
		@plan = Plan.new(plan_params)
		
		@plan.save
		servicios = params[:plan_servicio][:servicio_ids]

		descripciones = params[:plan_servicio][:descripcion]
		puts "descripciones " + descripciones.to_s

		plan_id = @plan.id
		if ! servicios.nil?
			servicios.each do |servicio|
			 	servicio_id = servicio
			 	descripcion = descripciones[servicio.to_i-1]
			 	@plan_servicio = PlanServicio.new
			 	@plan_servicio.servicio_id = servicio_id
			 	@plan_servicio.plan_id = plan_id
				@plan_servicio.descripcion = descripcion
				@plan_servicio.save
			end
		end

		redirect_to :controller => 'plans', :action => 'consultar'
	end

	def consultar
		if !usuario_signed_in?
        	redirect_to root_path
     	else

	       
	           @plans = Plan.order('id ASC')
	           @valor = true;
	           render "plans/plans"	
         
     	end
	end

	def update_estatus
		id = params[:idplan]
		estatus = params[:estatus]
		if Plan.update(id, :estatus => estatus)
			render :text =>'{ "success" : "true"}'
		else
			render :text => '{ "success" : "false"}'
		end
	end


	def eliminar
		id = params[:idplan]
		plan = Plan.where(id: id).first
		plan.destroy
      if plan.destroyed?
      	render :text =>'{ "success" : "true"}'
	  else
		render :text => '{ "success" : "false"}'
	   end
	end

	def consultar_plan
		id = params[:idplan]
		plan = Plan.includes(:frecuencia_pago).where(id: id).first
		monto = plan.costo.to_s
		meses = plan.frecuencia_pago.meses.to_s
		@tira ='{ "success" : "true", "meses" : "' + meses  + '", "monto" : "' + monto +'"}'
		render :text => @tira
	end

	def catalogo
       @plans = Plan.order('nombre ASC').page(params[:page]).per(9)
       render "plans/catalogo"	
	end

	def show
		id_plan = params[:id_plan]
		$administrable = false
		if usuario_signed_in?
			usuario = current_usuario
		    usuario.current_administrable = false
		    usuario.save
		end
		
		if usuario_signed_in?
			usuario_id = current_usuario.id
			@puntuacion =  Interaccion.where("producto_id = ?  AND tipo_interaccion = ? AND usuario_id = ? ", id_plan, Interaccion.tipo_interaccions["puntuacion"], usuario_id).first
		end

		if @puntuacion.nil?
			@puntuacion =  Interaccion.new
			@puntuacion.contenido = 0
		end

		@top_puntuacion = Plan.new.top_puntuacion
		@top_popular = Plan.new.top_popular
		@promedio =  Interaccion.where("producto_id = ?  AND tipo_interaccion = ? ", id_plan, Interaccion.tipo_interaccions["puntuacion"]).average(:contenido)
		@like = Interaccion.where( ["producto_id = ? AND usuario_id = ? AND tipo_interaccion = ?", id_plan, usuario_id, Interaccion.tipo_interaccions["me_gusta"]] ).first
		@plan = Plan.where("id = ?", id_plan).first	
		@comentarios = Interaccion.includes(:usuario).where("producto_id = ? and tipo_interaccion = ?", id_plan, Interaccion.tipo_interaccions["comentario"]).order("created_at ASC")
		@comentario = Interaccion.new()
		
		render "plans/show"
	end

	def puntuacion
		id_plan = params[:idplan]
		puntuacion = params[:plan]
		usuario_id = current_usuario.id
		@puntuacion = Interaccion.where( ["producto_id = ? AND usuario_id = ? AND tipo_interaccion = ?", id_plan, usuario_id, Interaccion.tipo_interaccions["puntuacion"]] ).first
		 
		if @puntuacion.nil?
			@puntuacion = Interaccion.new
			@puntuacion.plan_id = id_plan
			@puntuacion.usuario_id = usuario_id
			@puntuacion.contenido = puntuacion.to_s
			@puntuacion.tipo_interaccion =  Interaccion.tipo_interaccions["puntuacion"]
		else
			@puntuacion.contenido = puntuacion.to_s
		end
		
		
		if @puntuacion.save
			@promedio =  Interaccion.where("plan_id = ?  AND tipo_interaccion = ? ", id_plan, Interaccion.tipo_interaccions["puntuacion"]).average(:contenido)
      		render :text =>'{ "success" : "true", "promedio" : ' + @promedio.to_s + '}'
		else
			render :text => '{ "success" : "false"}'
		end
	end

	def share
		id_plan = params[:idplan]
		
		@share = Interaccion.new
		@share.producto_id = id_plan
		@share.usuario_id =  current_usuario.id
		@share.tipo_interaccion =  Interaccion.tipo_interaccions["compartir"]
		@share.save
		
		if @share.save
      		render :text =>'{ "success" : "true" }'
		else
			render :text => '{ "success" : "false"}'
		end
		
	end

	def like
		id_plan = params[:idplan]
		puntuacion = params[:puntuacion]
		usuario_id = current_usuario.id
		@like = Interaccion.where( ["producto_id = ? AND usuario_id = ? AND tipo_interaccion = ?", id_plan, usuario_id, Interaccion.tipo_interaccions["me_gusta"]] ).first
		 
		if @like.nil?
			@like = Interaccion.new
			@like.producto_id = id_plan
			@like.usuario_id = usuario_id
			@like.tipo_interaccion =  Interaccion.tipo_interaccions["me_gusta"]
			if @like.save
				icon =  "fa fa-thumbs-up"
	      		render :text =>'{ "success" : "true", "icon" : "fa fa-thumbs-up" }'
			else
				render :text => '{ "success" : "false"}'
			end
		else
			@like.destroy
			if @like.destroyed?
				icon =  "fa fa-thumbs-o-up "
				render :text =>'{ "success" : "true", "icon" : "fa fa-thumbs-o-up " }'
			else
			render :text => '{ "success" : "false"}'
			end
		end

	end


	private
		def plan_params
	      accessible = [ :nombre, :descripcion, :costo, :frecuencia_pago_id, :imagen, :formato_imagen] # extend with your own params
	      params.require(:plan).permit(accessible)
	    end

end

require "base64"
$IMAGEN_DEFAULT = "app/assets/images/index-plan3.jpg";
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
			@plan = Plan.new
			if request.subdomain.present?
				redirect_to root_path
			else
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
		puts "id " + id.to_s
		plan_edit.update(plan_params)

		plan_servicios = plan_edit.plan_servicio
		if ! plan_servicios.nil?
			plan_servicios.each do |plan_servicio|
				puts "plan des" + plan_servicio.descripcion.to_s
				puts "plan ser " + plan_servicio.servicio.nombre.to_s
				plan_servicio.destroy
			end
		end

		servicios = params[:plan_servicio][:servicio_ids]

		descripciones = params[:plan_servicio][:descripcion]
		puts "descripciones " + descripciones.to_s

		plan_id = plan_edit.id
		if ! servicios.nil?
			servicios.each do |servicio|
			 	servicio_id = servicio
			 	puts "servicio_id " + servicio_id
			 	descripcion = descripciones[servicio.to_i-1]
			 	puts "descripcion " + descripcion.to_s
			 	@plan_servicio = PlanServicio.new
			 	@plan_servicio.servicio_id = servicio_id
			 	@plan_servicio.plan_id = plan_id
				@plan_servicio.descripcion = descripcion
				@plan_servicio.save
			end
		end
		
		redirect_to :controller => 'plans', :action => 'consultar'

	end

	def save_imagen

		@id = params[:plan_id]

		@plan = Plan.where(["id = ?", @id]).first
					
		#Archivo subido por el usuario.
	    archivo = params[:imagen_id]

 		formato = "data:"+ archivo.content_type+";base64,"
		imagen = Base64.encode64(File.open(archivo.tempfile, "rb").read)

    	@plan.imagen = imagen

    	@plan.formato_imagen = formato

    	@plan.save
		
		redirect_to :controller => 'plans', :action => 'edit', id_plan: @id
	end
	
	def create
		@plan = Plan.new(plan_params)
		formato_imagen = "data:image/jpg;base64,"
    	imagen_plan = Base64.encode64(File.open($IMAGEN_DEFAULT, "rb").read)
		@plan.attributes  = {:imagen => imagen_plan, :formato_imagen => formato_imagen}
		@plan.save
		servicios = params[:plan_servicio][:servicio_ids]

		descripciones = params[:plan_servicio][:descripcion]
		puts "descripciones " + descripciones.to_s

		plan_id = @plan.id
		if ! servicios.nil?
			servicios.each do |servicio|
			 	servicio_id = servicio
			 	puts "servicio_id " + servicio_id
			 	descripcion = descripciones[servicio.to_i-1]
			 	puts "descripcion " + descripcion.to_s
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

	        @rol =  Rol.where(nombre: 'Administrador del sistema')
	        
	        @usuarioRol = UsuarioRol.where(usuario_id: current_usuario.id, rol_id: current_usuario.rol_actual.id) 

	        if @usuarioRol[0] == nil or @rol[0].id != current_usuario.rol_actual.id
	          redirect_to root_path
	        else
	           @plans = Plan.order('id ASC')
	           @valor = true;
	           render "plans/plans"	
	        end
         
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


	private
		def plan_params
	      accessible = [ :nombre, :descripcion, :costo, :frecuencia_pago_id] # extend with your own params
	      params.require(:plan).permit(accessible)
	    end

end

require "base64"
$FOTO_DEFAULT = "app/assets/images/index-plan3.jpg";
class PlansController < ApplicationController
	def validar_plan
	    if Plan.exists?(nombre: params[:plan][:nombre])
	    	render json: false
	    else
	    	render json: true
	    end
  	end

  	def validar_plan_update
	    if Plan.exists?(  ["nombre = ? AND  id <> ? ", params[:plan][:nombre], params[:idplan] ])  
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
				render  root_path
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
				render  root_path
			else
				id = params[:id_plan]
				@plan = Plan.where("id = ?", id).first
				puts "plan" + @plan.to_s
				render "plans/edit"
			end
		end
	end

	def save_edit
		id = params[:plan_id]

		plan_edit = Plan.where(["id = ?", id]).first

		#@plan_edit.update(plan_params)

		plan_servicios = plan_edit.plan_servicio
		if ! plan_servicios.nil?
			plan_servicios.each do |plan_servicio|
				puts "plan de" + plan_servicio.descripcion.to_s
				puts "plan se " + plan_servicio.servicio.nombre.to_s
			end
		end

		servicios = params[:plan][:servicio]

		plan_id = plan_edit.id
		if ! servicios.nil?
			servicios.each do |servicios|
			 	servicio_id = servicios[0]

			 	servicio = params[:plan][:servicio][servicio_id][:servicio]
			 	if !servicio.nil?


			 		descripcion = params[:plan][:servicio][servicio_id][:descripcion]
			 		
			 		@plan_servicio = PlanServicio.new
			 		@plan_servicio.servicio_id = servicio_id
			 		@plan_servicio.plan_id = plan_id
					@plan_servicio.descripcion = descripcion
					#@plan_servicio.save

			 		puts "servicio_id " + servicio_id
			 		puts "servicio " + servicio.to_s

			  		puts "descripcion " + descripcion.to_s
			 	end
			end
		end


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
    	imagen_plan = Base64.encode64(File.open($FOTO_DEFAULT, "rb").read)
		@plan.attributes  = {:imagen => imagen_plan, :formato_imagen => formato_imagen}
		@plan.save
		servicios = params[:plan][:servicio]
		plan_id = @plan.id
		if ! servicios.nil?
			servicios.each do |servicios|
			 	servicio_id = servicios[0]
			 	servicio = params[:plan][:servicio][servicio_id][:servicio]
			 	if !servicio.nil?
			 		descripcion = params[:plan][:servicio][servicio_id][:descripcion]
			 		
			 		@plan_servicio = PlanServicio.new
			 		@plan_servicio.servicio_id = servicio_id
			 		@plan_servicio.plan_id = plan_id
					@plan_servicio.descripcion = descripcion
					@plan_servicio.save

			 		puts "servicio_id " + servicio_id
			 		puts "servicio " + servicio.to_s

			  		puts "descripcion " + descripcion.to_s
			 	end
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


	private
		def plan_params
	      accessible = [ :nombre, :descripcion, :costo, :frecuencia_pago_id] # extend with your own params
	      params.require(:plan).permit(accessible)
	    end

end

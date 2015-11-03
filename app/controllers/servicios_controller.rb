class ServiciosController < ApplicationController

	def validar_servicio
	    if Servicio.exists?(nombre: params[:servicio][:nombre])
	    	render json: false
	    else
	    	render json: true
	    end
  	end

  	def validar_servicio_update
	    if Servicio.exists?(  ["nombre = ? AND  id <> ? ", params[:servicio][:nombre], params[:idservicio] ])  
	    	render json: false
	    else
	    	render json: true
	    end
  	end

  	def new
		if !usuario_signed_in?
			redirect_to root_path
		else
			@servicio = Servicio.new
			if request.subdomain.present?
				render  root_path
			else
				render "servicios/new"
			end
		end
	end

	def create
		@servicio = Servicio.new(servicio_params)
	    @servicio.save
		redirect_to :controller => 'servicios', :action => 'consultar'
	end

	def consultar
		if !usuario_signed_in?
        	render "portal/index"
     	else

	        @rol =  Rol.where(nombre: 'Administrador del sistema')
	        
	        @usuarioRol = UsuarioRol.where(usuario_id: current_usuario.id, rol_id: current_usuario.rol_actual.id) 

	        if @usuarioRol[0] == nil or @rol[0].id != current_usuario.rol_actual.id
	          render "portal/index_principal"
	        else
	           @servicios = Servicio.order('id ASC')
	           @valor = true;
	           render "servicios/servicios"	
	        end
         
     	end
	end
	
	def update_estatus
		id = params[:idServicio]
		estatus = params[:estatus]
		if Servicio.update(id, :estatus => estatus)
			render :text =>'{ "success" : "true"}'
		else
			render :text => '{ "success" : "false"}'
		end
	end


	def update
		id = params[:idServicio]
		nombre = params[:nombre]
		descripcion = params[:descripcion]
		if Servicio.update(id, :nombre => nombre, :descripcion => descripcion)
			render :text =>'{ "success" : "true"}'
		else

			render :text => '{ "success" : "false"}'
		end
	end

	def consultar_servicio
		id = params[:idServicio]
		@servicio = Servicio.where(id: id).first
		render :json => @servicio
	end


private
	 def servicio_params
      accessible = [ :nombre, :descripcion ] # extend with your own params
      params.require(:servicio).permit(accessible)
    end


end

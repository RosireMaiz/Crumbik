class RolsController < ApplicationController

	def validar_rol
	    if Rol.exists?(nombre: params[:rol][:nombre])
	    	render json: false
	    else
	    	render json: true
	    end
  	end

	def validar_rol_update
	    if Rol.exists?(  ["nombre = ? AND  id <> ? ", params[:rol][:nombre], params[:idrol] ])  
	    	render json: false
	    else
	    	render json: true
	    end
  	end

	def new
		if !usuario_signed_in?
			redirect_to root_path
		else
			@rol = Rol.new
			if request.subdomain.present?
				redirect_to root_path
			else
				render "rols/new"
			end
		end
	end

	def create
		@rol = Rol.new(rol_params)
	    @rol.save
	  	redirect_to :controller => 'rols', :action => 'consultar'
	end

	def consultar
		if !usuario_signed_in?
        	render "portal/index"
     	else

	        @rol =  Rol.where(nombre: 'Administrador del sistema')
	        
	        @usuarioRol = UsuarioRol.where(usuario_id: current_usuario.id, rol_id: current_usuario.rol_actual.id) 

	        if @usuarioRol[0] == nil or @rol[0].id != current_usuario.rol_actual.id
	          render root_path
	        else
	           @rols = Rol.order('id ASC')
	           @valor = true;
	           render "rols/rols"	
	        end
         
     	end
	end
	
	def update_estatus
		id = params[:idRol]
		estatus = params[:estatus]
		if Rol.update(id, :estatus => estatus)
			render :text =>'{ "success" : "true"}'
		else
			render :text => '{ "success" : "false"}'
		end
	end

	def update
		id = params[:idRol]
		nombre = params[:nombre]
		if Rol.update(id, :nombre => nombre)
			render :text =>'{ "success" : "true"}'
		else

			render :text => '{ "success" : "false"}'
		end
	end

	def eliminar
		id = params[:idrol]
		rol = Rol.where(id: id).first
		rol.destroy
      if rol.destroyed?
      	render :text =>'{ "success" : "true"}'
	  else
		render :text => '{ "success" : "false"}'
	   end
	end

	def consultar_rol
		id = params[:idrol]
		@rol = Rol.where(id: id).first
		render :json => @rol
	end

private
	 def rol_params
      accessible = [ :nombre ] # extend with your own params
      params.require(:rol).permit(accessible)
    end


end

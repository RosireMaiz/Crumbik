class DispositivosController < ApplicationController
	def validar_dispositivo
	    if Dispositivo.exists?(nombre: params[:dispositivo][:nombre])
	    	render json: false
	    else
	    	render json: true
	    end
  	end

  	def validar_dispositivo_update
	    if Dispositivo.exists?(  ["nombre = ? AND  id <> ? ", params[:dispositivo][:nombre], params[:iddispositivo] ])  
	    	render json: false
	    else
	    	render json: true
	    end
  	end

  	def new
		if !usuario_signed_in?
			redirect_to root_path
		else
			@dispositivo = Dispositivo.new
			if request.subdomain.present?
				render  root_path
			else
				render "dispositivos/new"
			end
		end
	end

	def create
		@dispositivo = Dispositivo.new(dispositivo_params)
	   	@dispositivo.save
		redirect_to :controller => 'dispositivos', :action => 'consultar'
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
	           @dispositivos = Dispositivo.order('id ASC')
	           @valor = true;
	           render "dispositivos/dispositivos"	
	        end
         
     	end
	end


	def update
		id = params[:iddispositivo]
		nombre = params[:nombre]
		if Dispositivo.update(id, :nombre => nombre)
			render :text =>'{ "success" : "true"}'
		else

			render :text => '{ "success" : "false"}'
		end
	end

	def eliminar
		id = params[:iddispositivo]
		dispositivo = Dispositivo.where(id: id).first
		dispositivo.destroy
      if dispositivo.destroyed?
      	render :text =>'{ "success" : "true"}'
	  else
		render :text => '{ "success" : "false"}'
	   end
	end

	def consultar_dispositivo
		id = params[:iddispositivo]
		@dispositivo = Dispositivo.where(id: id).first
		render :json => @dispositivo
	end


private
	def dispositivo_params
      accessible = [ :nombre ] # extend with your own params
      params.require(:dispositivo).permit(accessible)
    end
end
class TipoOrganizacionsController < ApplicationController
	def validar_tipo_organizacion
	    if TipoOrganizacion.exists?(nombre: params[:tipo_organizacion][:nombre])
	    	render json: false
	    else
	    	render json: true
	    end
  	end

	def validar_tipo_organizacion_update
	    if TipoOrganizacion.exists?(  ["nombre = ? AND  id <> ? ", params[:tipo_organizacion][:nombre], params[:id_tipo_organizacion] ])  
	    	render json: false
	    else
	    	render json: true
	    end
  	end

	def new
		if !usuario_signed_in?
			redirect_to root_path
		else
			@tipo_organizacion = TipoOrganizacion.new
			if request.subdomain.present?
				render  root_path
			else
				render "tipo_organizacions/new"
			end
		end
	end

	def create
		@tipo_organizacion = TipoOrganizacion.new(tipo_organizacion_params)
	    @tipo_organizacion.save
	  	redirect_to :controller => 'tipo_organizacions', :action => 'consultar'
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
	           @tipo_organizacions = TipoOrganizacion.order('id ASC')
	           @valor = true;
	           render "tipo_organizacions/tipo_organizacions"	
	        end
         
     	end
	end
	
	def update_estatus
		id = params[:id_tipo_organizacion]
		estatus = params[:estatus]
		if TipoOrganizacion.update(id, :estatus => estatus)
			render :text =>'{ "success" : "true"}'
		else
			render :text => '{ "success" : "false"}'
		end
	end

	def update
		id = params[:id_tipo_organizacion]
		nombre = params[:nombre]
		if TipoOrganizacion.update(id, :nombre => nombre)
			render :text =>'{ "success" : "true"}'
		else

			render :text => '{ "success" : "false"}'
		end
	end

	def eliminar
		id = params[:id_tipo_organizacion]
		tipo_organizacion = TipoOrganizacion.where(id: id).first
		tipo_organizacion.destroy
      if tipo_organizacion.destroyed?
      	render :text =>'{ "success" : "true"}'
	  else
		render :text => '{ "success" : "false"}'
	   end
	end

	def consultar_tipo_organizacion
		id = params[:id_tipo_organizacion]
		@tipo_organizacion = TipoOrganizacion.where(id: id).first
		render :json => @tipo_organizacion
	end

	private
		def tipo_organizacion_params
	      accessible = [ :nombre ] # extend with your own params
	      params.require(:tipo_organizacion).permit(accessible)
	    end

end

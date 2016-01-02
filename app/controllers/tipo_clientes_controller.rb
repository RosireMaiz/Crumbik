class TipoClientesController < ApplicationController
	def validar_tipo_cliente
	    if TipoCliente.exists?(nombre: params[:tipo_cliente][:nombre])
	    	render json: false
	    else
	    	render json: true
	    end
  	end

	def validar_tipo_cliente_update
	    if TipoCliente.exists?(  ["nombre = ? AND  id <> ? ", params[:tipo_cliente][:nombre], params[:id_tipo_cliente] ])  
	    	render json: false
	    else
	    	render json: true
	    end
  	end

	def new
		if !usuario_signed_in?
			redirect_to root_path
		else
			@tipo_cliente = TipoCliente.new
			if !request.subdomain.present?
				redirect_to root_path
			else
				render "tipo_clientes/new"
			end
		end
	end

	def create
		@tipo_cliente = TipoCliente.new(tipo_cliente_params)
	    @tipo_cliente.save
	  	redirect_to :controller => 'tipo_clientes', :action => 'consultar'
	end

	def consultar
		if !usuario_signed_in?
        	render "portal/index"
     	else

	        @rol =  Rol.where(nombre: 'Empresario')
	        
	        @usuarioRol = UsuarioRol.where(usuario_id: current_usuario.id, rol_id: current_usuario.rol_actual.id) 

	        if @usuarioRol[0] == nil or @rol[0].id != current_usuario.rol_actual.id
	          render root_path
	        else
	           @tipo_clientes = TipoCliente.order('id ASC')
	           @valor = true;
	           render "tipo_clientes/tipo_clientes"	
	        end
         
     	end
	end
	
	def update_estatus
		id = params[:id_tipo_cliente]
		estatus = params[:estatus]
		if TipoCliente.update(id, :estatus => estatus)
			render :text =>'{ "success" : "true"}'
		else
			render :text => '{ "success" : "false"}'
		end
	end

	def update
		id = params[:id_tipo_cliente]
		nombre = params[:nombre]
		descripcion = params[:descripcion]
		if TipoCliente.update(id, :nombre => nombre, :descripcion => descripcion)
			render :text =>'{ "success" : "true"}'
		else

			render :text => '{ "success" : "false"}'
		end
	end

	def eliminar
		id = params[:id_tipo_cliente]
		tipo_cliente = TipoCliente.where(id: id).first
		tipo_cliente.destroy
      if tipo_cliente.destroyed?
      	render :text =>'{ "success" : "true"}'
	  else
		render :text => '{ "success" : "false"}'
	   end
	end

	def consultar_tipo_cliente
		id = params[:id_tipo_cliente]
		@tipo_cliente = TipoCliente.where(id: id).first
		render :json => @tipo_cliente
	end

	private
		def tipo_cliente_params
	      accessible = [ :nombre, :descripcion ] # extend with your own params
	      params.require(:tipo_cliente).permit(accessible)
	    end
end

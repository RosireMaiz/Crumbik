class PaisController < ApplicationController
	def validar_pais
	    if Pais.exists?(nombre: params[:pais][:nombre])
	    	render json: false
	    else
	    	render json: true
	    end
  	end

  	def validar_pais_update
	    if Pais.exists?(  ["nombre = ? AND  id <> ? ", params[:pais][:nombre], params[:idpais] ])  
	    	render json: false
	    else
	    	render json: true
	    end
  	end

  	def new
		if !usuario_signed_in?
			redirect_to root_path
		else
			@pais = Pais.new
			if request.subdomain.present?
				render  root_path
			else
				render "pais/new"
			end
		end
	end

	def create
		@respuesta = Hash.new
		@pais = Pais.new(pais_params)
	   	@pais.save
		redirect_to :controller => 'pais', :action => 'consultar'
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
	           @pais = Pais.order('id ASC')
	           @valor = true;
	           render "pais/pais"	
	        end
         
     	end
	end
	
	def update_estatus
		id = params[:idpais]
		estatus = params[:estatus]
		if Pais.update(id, :estatus => estatus)
			render :text =>'{ "success" : "true"}'
		else
			render :text => '{ "success" : "false"}'
		end
	end


	def update
		id = params[:idpais]
		nombre = params[:nombre]
		iso = params[:iso]
		if Pais.update(id, :nombre => nombre, :iso => iso)
			render :text =>'{ "success" : "true"}'
		else

			render :text => '{ "success" : "false"}'
		end
	end

	def consultar_pais
		id = params[:idpais]
		@pais = Pais.where(id: id).first
		render :json => @pais
	end


private
	 def pais_params
      accessible = [ :nombre, :iso ] # extend with your own params
      params.require(:pais).permit(accessible)
    end
end

class FrecuenciaPagosController < ApplicationController
	def validar_frecuencia_pago
	    if FrecuenciaPago.exists?(nombre: params[:frecuencia_pago][:nombre])
	    	render json: false
	    else
	    	render json: true
	    end
  	end

  	def validar_frecuencia_pago_update
	    if FrecuenciaPago.exists?(  ["nombre = ? AND  id <> ? ", params[:frecuencia_pago][:nombre], params[:idfrecuenciapago] ])  
	    	render json: false
	    else
	    	render json: true
	    end
  	end

  	def new
		if !usuario_signed_in?
			redirect_to root_path
		else
			@frecuencia_pago = FrecuenciaPago.new
			if request.subdomain.present?
				redirect_to root_path
			else
				render "frecuencia_pagos/new"
			end
		end
	end

	def create
		@frecuencia_pago = FrecuenciaPago.new(frecuencia_pago_params)
	   	@frecuencia_pago.save
		redirect_to :controller => 'frecuencia_pagos', :action => 'consultar'
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
	           @frecuencia_pagos = FrecuenciaPago.order('id ASC')
	           @valor = true;
	           render "frecuencia_pagos/frecuencia_pagos"	
	        end
         
     	end
	end
	
	def update_estatus
		id = params[:idfrecuenciapago]
		estatus = params[:estatus]
		if FrecuenciaPago.update(id, :estatus => estatus)
			render :text =>'{ "success" : "true"}'
		else
			render :text => '{ "success" : "false"}'
		end
	end

	def update
		id = params[:idfrecuenciapago]
		nombre = params[:nombre]
		meses = params[:meses]
		if FrecuenciaPago.update(id, :nombre => nombre, :meses => meses)
			render :text =>'{ "success" : "true"}'
		else

			render :text => '{ "success" : "false"}'
		end
	end

	def eliminar
		id = params[:idfrecuenciapago]
		frecuencia_pago = FrecuenciaPago.where(id: id).first
		frecuencia_pago.destroy
      if frecuencia_pago.destroyed?
      	render :text =>'{ "success" : "true"}'
	  else
		render :text => '{ "success" : "false"}'
	   end
	end

	def consultar_frecuencia_pago
		id = params[:idfrecuenciapago]
		@frecuencia_pago = FrecuenciaPago.where(id: id).first
		render :json => @frecuencia_pago
	end

private
	 def frecuencia_pago_params
      accessible = [ :nombre, :meses ] # extend with your own params
      params.require(:frecuencia_pago).permit(accessible)
    end
end

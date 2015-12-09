class ModoPagosController < ApplicationController

	def validar_modo_pago
	    if ModoPago.exists?(nombre: params[:modo_pago][:nombre])
	    	render json: false
	    else
	    	render json: true
	    end
  	end

	def validar_modo_pago_update
	    if ModoPago.exists?(  ["nombre = ? AND  id <> ? ", params[:modo_pago][:nombre], params[:idmodopago] ])  
	    	render json: false
	    else
	    	render json: true
	    end
  	end

	def new
		if !usuario_signed_in?
			redirect_to root_path
		else
			@modo_pago = ModoPago.new
			if request.subdomain.present?
				redirect_to root_path
			else
				render "modo_pagos/new"
			end
		end
	end

	def create
		@modo_pago = ModoPago.new(modo_pago_params)
	    @modo_pago.save
	  	redirect_to :controller => 'modo_pagos', :action => 'consultar'
	end

	def consultar
		if !usuario_signed_in?
        	render "portal/index"
     	else

	        @rol =  Rol.where(nombre: 'Administrador del sistema')
	        
	        @usuarioRol = UsuarioRol.where(usuario_id: current_usuario.id, rol_id: current_usuario.rol_actual.id) 

	        if @usuarioRol[0] == nil or @rol[0].id != current_usuario.rol_actual.id
	          redirect_to root_path
	        else
	           @modo_pagos = ModoPago.order('id ASC')
	           @valor = true;
	           render "modo_pagos/modo_pagos"	
	        end
         
     	end
	end
	
	def update_estatus
		id = params[:idmodopago]
		estatus = params[:estatus]
		if ModoPago.update(id, :estatus => estatus)
			render :text =>'{ "success" : "true"}'
		else
			render :text => '{ "success" : "false"}'
		end
	end

	def update
		id = params[:idmodopago]
		nombre = params[:nombre]
		if ModoPago.update(id, :nombre => nombre)
			render :text =>'{ "success" : "true"}'
		else

			render :text => '{ "success" : "false"}'
		end
	end

	def eliminar
		id = params[:idmodopago]
		modo_pago = ModoPago.where(id: id).first
		modo_pago.destroy
      if modo_pago.destroyed?
      	render :text =>'{ "success" : "true"}'
	  else
		render :text => '{ "success" : "false"}'
	   end
	end

	def consultar_modo_pago
		id = params[:idmodopago]
		@modo_pago = ModoPago.where(id: id).first
		render :json => @modo_pago
	end

	private
		def modo_pago_params
	      accessible = [ :nombre ] # extend with your own params
	      params.require(:modo_pago).permit(accessible)
	    end
end

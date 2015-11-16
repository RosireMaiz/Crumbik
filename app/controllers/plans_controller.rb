class PlansController < ApplicationController
	def validar_plan
	    if Plan.exists?(nombre: params[:plan][:nombre])
	    	render json: false
	    else
	    	render json: true
	    end
  	end

  	def validar_plan_update
	    if Pan.exists?(  ["nombre = ? AND  id <> ? ", params[:plan][:nombre], params[:idplan] ])  
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

	def create
		@plan = Plan.new(plan_params)
		@plan.save
		redirect_to :controller => 'plans', :action => 'consultar'
	end

	def consultar
		if !usuario_signed_in?
        	render root_path
     	else

	        @rol =  Rol.where(nombre: 'Administrador del sistema')
	        
	        @usuarioRol = UsuarioRol.where(usuario_id: current_usuario.id, rol_id: current_usuario.rol_actual.id) 

	        if @usuarioRol[0] == nil or @rol[0].id != current_usuario.rol_actual.id
	          render root_path
	        else
	           @plans = Plan.order('id ASC')
	           @valor = true;
	           render "plans/plans"	
	        end
         
     	end
	end


	private
		def plan_params
	      accessible = [ :nombre, :descripcion, :frecuencia_pago_id] # extend with your own params
	      params.require(:plan).permit(accessible)
	    end

end

class VariablePsicograficasController < ApplicationController
	def validar_variable_psicografica
	    if VariablePsicografica.exists?(nombre: params[:variable_psicografica][:nombre])
	    	render json: false
	    else
	    	render json: true
	    end
  	end

	def validar_variable_psicografica_update
	    if VariablePsicografica.exists?(  ["nombre = ? AND  id <> ? ", params[:variable_psicografica][:nombre], params[:id_variable_psicografica] ])  
	    	render json: false
	    else
	    	render json: true
	    end
  	end

	def new
		if !usuario_signed_in?
			redirect_to root_path
		else
			@variable_psicografica = VariablePsicografica.new
			if !request.subdomain.present?
				redirect_to root_path
			else
				render "variable_psicograficas/new"
			end
		end
	end

	def create
		@variable_psicografica = VariablePsicografica.new(variable_psicografica_params)
	    @variable_psicografica.save
	  	redirect_to :controller => 'variable_psicograficas', :action => 'consultar'
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
	           @variable_psicograficas = VariablePsicografica.order('id ASC')
	           @valor = true;
	           render "variable_psicograficas/variable_psicograficas"	
	        end
         
     	end
	end
	
	def update_estatus
		id = params[:id_variable_psicografica]
		estatus = params[:estatus]
		if VariablePsicografica.update(id, :estatus => estatus)
			render :text =>'{ "success" : "true"}'
		else
			render :text => '{ "success" : "false"}'
		end
	end

	def update
		id = params[:id_variable_psicografica]
		nombre = params[:nombre]
		if VariablePsicografica.update(id, :nombre => nombre)
			render :text =>'{ "success" : "true"}'
		else

			render :text => '{ "success" : "false"}'
		end
	end

	def eliminar
		id = params[:id_variable_psicografica]
		variable_psicografica = VariablePsicografica.where(id: id).first
		variable_psicografica.destroy
      if variable_psicografica.destroyed?
      	render :text =>'{ "success" : "true"}'
	  else
		render :text => '{ "success" : "false"}'
	   end
	end

	def consultar_variable_psicografica
		id = params[:id_variable_psicografica]
		@variable_psicografica = VariablePsicografica.where(id: id).first
		render :json => @variable_psicografica
	end

	private
		def variable_psicografica_params
	      accessible = [ :nombre ] # extend with your own params
	      params.require(:variable_psicografica).permit(accessible)
	    end

end
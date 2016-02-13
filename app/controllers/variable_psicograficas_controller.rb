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
				@variable_psicografica.categorium.build
				render "variable_psicograficas/new"
			end
		end
	end

	def create
		@variable_psicografica = VariablePsicografica.new(variable_psicografica_params)
	    @variable_psicografica.save
	  	redirect_to :controller => 'variable_psicograficas', :action => 'consultar'
	end

	def edit
		if !usuario_signed_in?
			redirect_to root_path
		else
			@variable_psicografica = VariablePsicografica.new
			if !request.subdomain.present?
				redirect_to root_path
			else
				id = params[:id_variable_psicografica]
				@variable_psicografica = VariablePsicografica.where("id = ?", id).first
				render "variable_psicograficas/edit"
			end
		end
	end

	def save_edit
		id = params[:id_variable_psicografica]

		variable_edit = VariablePsicografica.where(["id = ?", id]).first
		variable_edit.update(variable_psicografica_edit_params)

		variable_categorias = variable_edit.variable_categorium
		if ! variable_categorias.nil?
			variable_categorias.each do |variable_categorium|
				variable_categorium.destroy
			end
		end

		categorias = params[:variable_psicografica][:categorium_ids]

		variable_id = variable_edit.id
		if ! categorias.nil?
			categorias.each do |categorium|
				if !categorium.blank?
			 		@variable_categorium = VariableCategorium.new
			 		@variable_categorium.categoria_id = categorium
			 		@variable_categorium.variable_psicografica_id = variable_id
					@variable_categorium.save
				end
			end
		end
		
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

	def eliminar
		id = params[:id_variable_psicografica]
		variable_psicografica = VariablePsicografica.where(id: id).first
		
		
		variable_categorias = variable_psicografica.variable_categorium
		if ! variable_categorias.nil?
			variable_categorias.each do |variable_categorium|
				variable_categorium.destroy
			end
		end
		
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
	      accessible = [ :nombre, :descripcion, :categorium_ids => [] ] # extend with your own params
	      params.require(:variable_psicografica).permit(accessible)
	    end
end
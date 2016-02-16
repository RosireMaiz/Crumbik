class CategoriasController < ApplicationController
	def validar_categoria
	    if Categorium.exists?(nombre: params[:categorium][:nombre])
	    	render json: false
	    else
	    	render json: true
	    end
  	end

	def validar_categoria_update
	    if Categorium.exists?(  ["nombre = ? AND  id <> ? ", params[:categoria][:nombre], params[:id_categoria] ])  
	    	render json: false
	    else
	    	render json: true
	    end
  	end

	def new
		if !usuario_signed_in?
			redirect_to root_path
		else
			@categoria = Categorium.new
			if !request.subdomain.present?
				redirect_to root_path
			else
				@categoria.variable_psicografica.build
				render "categorias/new"
			end
		end
	end


	def create
		@categoria = Categorium.new(categoria_params)
	    @categoria.save
		variables = params[:categorium][:variable_psicografica_ids]
		categoria_id = @categoria.id
		if ! variables.nil?
			variables.each do |variable|
				if !variable.blank?
			 		@variable_categorium = VariableCategorium.new
			 		@variable_categorium.categoria_id = variable
			 		@variable_categorium.variable_psicografica_id = categoria_id
					@variable_categorium.save
				end
			end
		end
		redirect_to :controller => 'categorias', :action => 'consultar'
	end

	def edit
		if !usuario_signed_in?
			redirect_to root_path
		else
			@categoria = Categorium.new
			if !request.subdomain.present?
				redirect_to root_path
			else
				id = params[:id_categoria]
				@categoria = Categorium.where("id = ?", id).first
				render "categorias/edit"
			end
		end
	end

	def save_edit
		id = params[:id_categoria]

		categoria_edit = Categorium.where(["id = ?", id]).first
		categoria_edit.update(categoria_params)

		variable_categorias = categoria_edit.variable_categorium
		if ! variable_categorias.nil?
			variable_categorias.each do |variable_categorium|
				variable_categorium.destroy
			end
		end

		variable_psicograficas = params[:categorium][:variable_psicografica_ids]

		categoria_id = categoria_edit.id
		if ! variable_psicograficas.nil?
			variable_psicograficas.each do |variable_psicografica|
				if !variable_psicografica.blank?
			 		@variable_categorium = VariableCategorium.new
			 		@variable_categorium.categoria_id = categoria_id
			 		@variable_categorium.variable_psicografica_id = variable_psicografica
					@variable_categorium.save
				end
			end
		end
		
		redirect_to :controller => 'categorias', :action => 'consultar'

	end

	def consultar
		if !usuario_signed_in?
        	render "portal/index"
     	else

	           @categorias = Categorium.order('id ASC')
	           render "categorias/categorias"	
         
     	end
	end
	
	def update_estatus
		id = params[:id_categoria]
		estatus = params[:estatus]
		if Categorium.update(id, :estatus => estatus)
			render :text =>'{ "success" : "true"}'
		else
			render :text => '{ "success" : "false"}'
		end
	end

	def eliminar
		id = params[:id_categoria]
		categoria = Categorium.where(id: id).first
		
		
		variable_categorias = categoria.variable_categorium
		if ! variable_categorias.nil?
			variable_categorias.each do |variable_categorium|
				variable_categorium.destroy
			end
		end
		
		categoria.destroy
      if categoria.destroyed?
      	render :text =>'{ "success" : "true"}'
	  else
		render :text => '{ "success" : "false"}'
	   end
	end

	def consultar_categoria
		id = params[:id_categoria]
		@categoria = Categorium.where(id: id).first
		render :json => @categoria
	end

	private

	    def categoria_params
	      accessible = [ :nombre, :descripcion] # extend with your own params
	      params.require(:categorium).permit(accessible)
	    end
end
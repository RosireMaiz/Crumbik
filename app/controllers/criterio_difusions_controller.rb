class CriterioDifusionsController < ApplicationController
	
	def validar_criterio_difusion
	    if CriterioDifusion.exists?(nombre: params[:criterio_difusion][:nombre])
	    	render json: false
	    else
	    	render json: true
	    end
  	end

  	def validar_criterio_difusion_update
	    if CriterioDifusion.exists?(  ["nombre = ? AND  id <> ? ", params[:criterio_difusion][:nombre], params[:id_criterio_difusion] ])  
	    	render json: false
	    else
	    	render json: true
	    end
  	end

  	def new
		if !usuario_signed_in?
			redirect_to root_path
		else
			@criterio_difusion = CriterioDifusion.new
			@tables = ActiveRecord::Base.connection.tables
			@columns_subconsulta = ActiveRecord::Base.connection.columns(@tables.first)
			@tables_filter ||= Array.new
			@tables_filter.push("usuarios")
			@columns = ActiveRecord::Base.connection.columns("usuarios")
			@tables.each.each do |table|
				if ActiveRecord::Base.connection.column_exists?(table, "usuario_id") 
					@tables_filter.push(table)
				end 
			end 
			render "criterio_difusions/new"
		end
	end

	def create
		@criterio_difusion = CriterioDifusion.new(criterio_difusion_params)
		@respuesta = Hash.new
	   	if @criterio_difusion.save
	   		@respuesta["codigo"] = 200
	       	@respuesta["url"] = "/criterios_difusion"
	   	else
	   		@respuesta["codigo"] = 500
	       @respuesta["errores"] = @criterio_difusion.errors.full_messages
	   	end
	    render json: @respuesta
	end

	def consultar
		if !usuario_signed_in?
        	render "portal/index"
     	else
     		
				@criterio_difusions = CriterioDifusion.order('id ASC')
				@tables = ActiveRecord::Base.connection.tables
				@columns_subconsulta = ActiveRecord::Base.connection.columns(@tables.first)
				@tables_filter ||= Array.new
				@tables_filter.push("usuarios")
				@columns = ActiveRecord::Base.connection.columns("usuarios")
				@tables.each.each do |table|
					if ActiveRecord::Base.connection.column_exists?(table, "usuario_id") 
						@tables_filter.push(table)
					end 
				end 
				   render "criterio_difusions/criterio_difusions"	
     	end
	end

	def update_estatus
		id = params[:id_criterio_difusion]
		estatus = params[:estatus]
		if CriterioDifusion.update(id, :estatus => estatus)
			render :text =>'{ "success" : "true"}'
		else
			render :text => '{ "success" : "false"}'
		end
	end

	def update
		id = params[:id_criterio_difusion]
		nombre = params[:nombre]
		descripcion = params[:descripcion]
		tabla = params[:tabla]
		campo_comparacion = params[:campo_comparacion]
		campo_seleccion = params[:campo_seleccion]
		tipo_consulta = CriterioDifusion.tipo_consulta["personalizada"]	
		if CriterioDifusion.update(id, :nombre => nombre,  :tabla => tabla,  :descripcion => descripcion ,  :campo_seleccion => campo_seleccion,  :campo_comparacion => campo_comparacion,  :tabla => tabla, :tipo_consulta => tipo_consulta )
			render :text =>'{ "success" : "true"}'
		else
			render :text => '{ "success" : "false"}'
		end
	end

	def eliminar
		id = params[:id_criterio_difusion]
		criterio_difusion = CriterioDifusion.where(id: id).first
		criterio_difusion.destroy
      if criterio_difusion.destroyed?
      	render :text =>'{ "success" : "true"}'
	  else
		render :text => '{ "success" : "false"}'
	   end
	end

	def consultar_criterio_difusion
		id = params[:id_criterio_difusion]
		@criterio_difusion = CriterioDifusion.where(id: id).first
		render :json => @criterio_difusion
	end

	def update_columns
		table = params[:table]
		@columns = ActiveRecord::Base.connection.columns(table)
		render :json => @columns	
	end


private
	def criterio_difusion_params
      accessible = [ :nombre, :descripcion, :tabla, :campo_comparacion, :campo_seleccion, :tipo_consulta ] # extend with your own params
      params.require(:criterio_difusion).permit(accessible)
    end

end


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
			if request.subdomain.present?
				redirect_to root_path
			else
				render "criterio_difusions/new"
			end
		end
	end

	def create
		@criterio_difusion = CriterioDifusion.new(criterio_difusion_params)
	   	@criterio_difusion.save
		redirect_to :controller => 'criterio_difusions', :action => 'consultar'
	end

	def consultar
		if !usuario_signed_in?
        	render "portal/index"
     	else
	           @criterio_difusions = CriterioDifusion.order('id ASC')
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
		if CriterioDifusion.update(id, :nombre => nombre,  :tabla => tabla,  :descripcion => descripcion,  :campo_comparacion => campo_comparacion,  :tabla => tabla )
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


private
	def criterio_difusion_params
      accessible = [ :nombre, :descripcion, :tabla, :campo_comparacion ] # extend with your own params
      params.require(:criterio_difusion).permit(accessible)
    end

end


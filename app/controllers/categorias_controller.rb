class CategoriasController < ApplicationController
	def validar_categoria
	    if Categorium.exists?(nombre: params[:categoria][:nombre])
	    	render json: false
	    else
	    	render json: true
	    end
  	end

	def validar_categoria_update
	    if Categorium.exists?(  ["nombre = ? AND  id <> ? ", params[:categoria][:nombre], params[:idcategoria] ])  
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
				render "categorias/new"
			end
		end
	end

	def create
		@categoria = Categorium.new(categoria_params)
	    @categoria.save
	  	redirect_to :controller => 'categorias', :action => 'consultar'
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
	           @categorias = Categorium.order('id ASC')
	           @valor = true;
	           render "categorias/categorias"	
	        end
         
     	end
	end
	
	def update_estatus
		id = params[:idcategoria]
		estatus = params[:estatus]
		if Categorium.update(id, :estatus => estatus)
			render :text =>'{ "success" : "true"}'
		else
			render :text => '{ "success" : "false"}'
		end
	end

	def update
		id = params[:idcategoria]
		nombre = params[:nombre]
		descripcion = params[:descripcion]
		if Categorium.update(id, :nombre => nombre, :descripcion => descripcion)
			render :text =>'{ "success" : "true"}'
		else

			render :text => '{ "success" : "false"}'
		end
	end

	def eliminar
		id = params[:idcategoria]
		categoria = Categorium.where(id: id).first
		categoria.destroy
      if categoria.destroyed?
      	render :text =>'{ "success" : "true"}'
	  else
		render :text => '{ "success" : "false"}'
	   end
	end

	def consultar_categoria
		id = params[:idcategoria]
		@categoria = Categorium.where(id: id).first
		render :json => @categoria
	end

	private
		def categoria_params
	      accessible = [ :nombre, :descripcion ] # extend with your own params
	      params.require(:categorium).permit(accessible)
	    end
end

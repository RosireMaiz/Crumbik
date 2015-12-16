class ProductosController < ApplicationController

	def validar_producto
	    if Producto.exists?(nombre: params[:producto][:nombre])
	    	render json: false
	    else
	    	render json: true
	    end
  	end

	def validar_producto_update
	    if Producto.exists?(  ["nombre = ? AND  id <> ? ", params[:producto][:nombre], params[:idproducto] ])  
	    	render json: false
	    else
	    	render json: true
	    end
  	end

	def new
		if !usuario_signed_in?
			redirect_to root_path
		else
			@producto = Producto.new
			if !request.subdomain.present?
				redirect_to root_path
			else
				render "productos/new"
			end
		end
	end

	def create
		@producto = Producto.new(producto_params)
	    #@producto.save
	  	#redirect_to :controller => 'productos', :action => 'consultar'
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
	           @productos = Producto.order('id ASC')
	           @categorias = Categorium.order('id ASC')
	           @valor = true;
	           render "productos/productos"	
	        end
         
     	end
	end

	private
	 def producto_params
      accessible = [ :nombre ] # extend with your own params
      params.require(:producto).permit(accessible)
    end

	
end

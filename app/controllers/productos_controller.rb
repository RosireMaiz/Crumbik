require "base64"
$IMAGEN_DEFAULT = "app/assets/images/producto.png";
class ProductosController < ApplicationController

	def new
		if !usuario_signed_in?
			redirect_to root_path
		else
			if !request.subdomain.present?
				redirect_to root_path
			else
				@producto = Producto.new
				formato_imagen = "data:image/png;base64,"
    			imagen = Base64.encode64(File.open($IMAGEN_DEFAULT, "rb").read)
    			@producto.formato_imagen = formato_imagen
    			@producto.imagen = imagen
				render "productos/new"
			end
		end
	end

	def create
		@producto = Producto.new(producto_params)
	    @producto.save
	  	redirect_to :controller => 'productos', :action => 'consultar'
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
	           @productos = Producto.order('id ASC').page(params[:page]).per(9)
	           @categorias = Categorium.order('id ASC')
	           @valor = true;
	           render "productos/productos"	
	        end
         
     	end
	end

	def edit
		if !usuario_signed_in?
			redirect_to root_path
		else
			if !request.subdomain.present?
				redirect_to root_path
			else
				id = params[:id_producto]
				@producto = Producto.where("id = ?", id).first	
				render "productos/edit"
			end
		end
	end

	def save_edit
		id = params[:producto_id]

		producto_edit = Producto.where(["id = ?", id]).first
		
		producto_edit.update(producto_params)

		redirect_to :controller => 'productos', :action => 'consultar'
	end

	def update_estatus
		id = params[:idproducto]
		estatus = params[:estatus]
		if Producto.update(id, :estatus => estatus)
			render :text =>'{ "success" : "true"}'
		else
			render :text => '{ "success" : "false"}'
		end
	end


	def eliminar
		id = params[:idproducto]
		producto = Producto.where(id: id).first
		producto.destroy
      if producto.destroyed?
      	render :text =>'{ "success" : "true"}'
	  else
		render :text => '{ "success" : "false"}'
	   end
	end

	private
	 def producto_params
      accessible = [ :nombre,  :precio, :descripcion,  :formato_imagen, :imagen, :categoria_id  ] # extend with your own params
      params.require(:producto).permit(accessible)
    end

end
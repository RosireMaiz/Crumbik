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

	def catalogo
       @productos = Producto.order('id ASC').page(params[:page]).per(9)
       @categorias = Categorium.order('id ASC')
       @valor = true;
       render "productos/catalogo"	
	end

	def show
		id_producto = params[:id_producto]
		
		if usuario_signed_in?
			usuario_id = current_usuario.id
			@puntuacion = Puntuacion.where( ["producto_id = ? AND usuario_id = ? ", id_producto, usuario_id] ).first
		end

		if @puntuacion.nil?
			@puntuacion =  Puntuacion.new
			@puntuacion.puntuacion = 0
		end

		@promedio = Puntuacion.where("producto_id = ? ", id_producto).average(:puntuacion)

		@producto = Producto.where("id = ?", id_producto).first	
		@comentarios = Comentario.includes(:usuario).where("producto_id = ?", id_producto).order("created_at ASC")
		@comentario = Comentario.new
		
		render "productos/show"
	end

	def puntuacion
		id_producto = params[:idproducto]
		puntuacion = params[:puntuacion]
		usuario_id = current_usuario.id
		@puntuacion = Puntuacion.where( ["producto_id = ? AND usuario_id = ? ", id_producto, usuario_id] ).first
		
		if @puntuacion.nil?
			@puntuacion = Puntuacion.new
			@puntuacion.producto_id = id_producto
			@puntuacion.usuario_id = usuario_id
			@puntuacion.puntuacion = puntuacion
		else
			@puntuacion.puntuacion = puntuacion	
		end
		
		
		if @puntuacion.save
			@promedio = Puntuacion.where("producto_id = ? ", id_producto).average(:puntuacion)
      		render :text =>'{ "success" : "true", "promedio" : ' + @promedio.to_s + '}'
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

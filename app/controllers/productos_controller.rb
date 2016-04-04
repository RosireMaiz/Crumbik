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
           @productos = Producto.order('nombre ASC').page(params[:page]).per(9)
           @categorias = Categorium.order('nombre ASC')
           @valor = true;
           render "productos/productos"	
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
		#require 'rubygems'
		#require 'twitter'
		#		autenticacion = Autenticacion.where("usuario_id = ? AND provider = ?",current_usuario.id, "twitter").first
		#		client = Twitter::REST::Client.new do |config|
		#		  config.consumer_key        = "iLW5ICM65xM9cO7npmEZRTSKz"
		#		  config.consumer_secret     = "qXwz81sGgFPC09nFu9o17vo7HEhlIna9dnJ1xVlMTr9qldWCOm"
		#		  config.access_token        = autenticacion.oauth_token
		#		  config.access_token_secret = autenticacion.oauth_secret
		#		end

		#		ret = client.update('Tweet prueba')
		#		puts "id tweet " + ret.id.to_s
		#		@id = ret.id
		#		tweet = client.status(@id)
		#		@cantidad = tweet.favorite_count
       @productos = Producto.order('nombre ASC').page(params[:page]).per(9)
       @categorias = Categorium.order('nombre ASC')
       $administrable = false
		if usuario_signed_in?
			usuario = current_usuario
		    usuario.current_administrable = false
		    usuario.save
		end
       render "productos/catalogo"	
	end

	def show
		id_producto = params[:id_producto]
		$administrable = false
		if usuario_signed_in?
			usuario = current_usuario
		    usuario.current_administrable = false
		    usuario.save
		end
		
		if usuario_signed_in?
			usuario_id = current_usuario.id
			@puntuacion =  Interaccion.where("producto_id = ?  AND tipo_interaccion = ? AND usuario_id = ? ", id_producto, Interaccion.tipo_interaccions["puntuacion"], usuario_id).first
		end

		if @puntuacion.nil?
			@puntuacion =  Interaccion.new
			@puntuacion.contenido = 0
		end

		@top_puntuacion = Producto.new.top_puntuacion
		@top_popular = Producto.new.top_popular
		@promedio =  Interaccion.where("producto_id = ?  AND tipo_interaccion = ? ", id_producto, Interaccion.tipo_interaccions["puntuacion"]).average(:contenido)
		@like = Interaccion.where( ["producto_id = ? AND usuario_id = ? AND tipo_interaccion = ?", id_producto, usuario_id, Interaccion.tipo_interaccions["me_gusta"]] ).first
		@producto = Producto.where("id = ?", id_producto).first	
		@comentarios = Interaccion.includes(:usuario).where("producto_id = ? and tipo_interaccion = ?", id_producto, Interaccion.tipo_interaccions["comentario"]).order("created_at ASC")
		@comentario = Interaccion.new()
		
		render "productos/show"
	end

	def puntuacion
		id_producto = params[:idproducto]
		puntuacion = params[:puntuacion]
		usuario_id = current_usuario.id
		@puntuacion = Interaccion.where( ["producto_id = ? AND usuario_id = ? AND tipo_interaccion = ?", id_producto, usuario_id, Interaccion.tipo_interaccions["puntuacion"]] ).first
		 
		if @puntuacion.nil?
			@puntuacion = Interaccion.new
			@puntuacion.producto_id = id_producto
			@puntuacion.usuario_id = usuario_id
			@puntuacion.contenido = puntuacion.to_s
			@puntuacion.tipo_interaccion =  Interaccion.tipo_interaccions["puntuacion"]
		else
			@puntuacion.contenido = puntuacion.to_s
		end
		
		
		if @puntuacion.save
			@promedio =  Interaccion.where("producto_id = ?  AND tipo_interaccion = ? ", id_producto, Interaccion.tipo_interaccions["puntuacion"]).average(:contenido)
      		render :text =>'{ "success" : "true", "promedio" : ' + @promedio.to_s + '}'
		else
			render :text => '{ "success" : "false"}'
		end
	end

	def share
		id_producto = params[:idproducto]
		
		@share = Interaccion.new
		@share.producto_id = id_producto
		@share.usuario_id =  current_usuario.id
		@share.tipo_interaccion =  Interaccion.tipo_interaccions["compartir"]
		@share.save
		
		if @share.save
      		render :text =>'{ "success" : "true" }'
		else
			render :text => '{ "success" : "false"}'
		end
		
	end

	def like
		id_producto = params[:idproducto]
		puntuacion = params[:puntuacion]
		usuario_id = current_usuario.id
		@like = Interaccion.where( ["producto_id = ? AND usuario_id = ? AND tipo_interaccion = ?", id_producto, usuario_id, Interaccion.tipo_interaccions["me_gusta"]] ).first
		 
		if @like.nil?
			@like = Interaccion.new
			@like.producto_id = id_producto
			@like.usuario_id = usuario_id
			@like.tipo_interaccion =  Interaccion.tipo_interaccions["me_gusta"]
			if @like.save
				icon =  "fa fa-thumbs-up"
	      		render :text =>'{ "success" : "true", "icon" : "fa fa-thumbs-up" }'
			else
				render :text => '{ "success" : "false"}'
			end
		else
			@like.destroy
			if @like.destroyed?
				icon =  "fa fa-thumbs-o-up "
				render :text =>'{ "success" : "true", "icon" : "fa fa-thumbs-o-up " }'
			else
			render :text => '{ "success" : "false"}'
			end
		end

	end

	def consulta_interaccion_productos
		if !usuario_signed_in?
			redirect_to root_path
		else
			render "productos/graficas"
		end
	end

	private
	 def producto_params
      accessible = [ :nombre,  :precio, :descripcion,  :formato_imagen, :imagen, :categoria_id  ] # extend with your own params
      params.require(:producto).permit(accessible)
    end

end

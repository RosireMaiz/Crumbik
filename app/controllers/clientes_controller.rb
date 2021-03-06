require 'twitter'
class ClientesController < ApplicationController
 TWITTER_SETTINGS={:site=>"http://api.twitter.com", :request_endpoint => 'http://api.twitter.com',}
	def validar_email_cliente
		if Cliente.exists?(email: params[:cliente][:email])
			render json: false
		else
			render json: true
		end
	end
	
	def validar_email_cliente_update
		if Cliente.exists?( ["email = ? AND  id <> ? ",  params[:cliente][:email],  params[:idcliente] ])
			render json: false
		else
			render json: true
		end
	end

	def new
		if !usuario_signed_in?
			redirect_to root_path
		else
			@cliente = Cliente.new

			if !request.subdomain.present?
				redirect_to root_path
			else		
				render "clientes/new"
			end
		end
	end

	def create
		@cliente = Cliente.new(cliente_params)
	    @cliente.save
	  	redirect_to :controller => 'clientes', :action => 'consultar'
	end

	def consultar
		if !usuario_signed_in?
        	redirect_to root_path
     	else
     			#menuprueba = Menu.where(rol_id: current_usuario.rol_actual.id).first
				#puts "menuprueba " + menuprueba.id.to_s
				#puts "url " + request.fullpath
				#opcion = OpcionMenu.where(["url = ? AND menu_id = ?", request.fullpath, menuprueba.id]).first
				#puts "opcion " + opcion.id.to_s
				#if !opcion.blank?
					#puts "url " + request.fullpath
				#end
				require 'rubygems'
require 'twitter'

				client = Twitter::REST::Client.new do |config|
				  config.consumer_key        = "iLW5ICM65xM9cO7npmEZRTSKz"
				  config.consumer_secret     = "qXwz81sGgFPC09nFu9o17vo7HEhlIna9dnJ1xVlMTr9qldWCOm"
				  config.access_token        = "72471749-c1rontqDpqjg5Xho2ZvQH4GWQOQNFMNOmqbjzYMEV"
				  config.access_token_secret = "El3vJnqM2fwb2GXQYgcGYbwq04ooJ4wAiIJAg514dGYrO"

				end

				#ret = client.update('Prueba Tweet')
				#puts "id tweet " + ret.id.to_s
				#@id = ret.id
				#@tweet = client.status(@id)
				#@cantidad = @tweet.favorite_count
				#puts "tweet " + @tweet.to_s

				#path = "1.1/statuses/lookup.json"
				#ids = ['693845076523499520']

				#@response = Twitter::REST::Request.new(client, 'get', path, {id: ids, map: true}).perform
     		@tipo_clientes = TipoCliente.order('nombre ASC')
           	@clientes = Cliente.order('id ASC')
           	render "clientes/clientes"	
     	end
	end

	def update_estatus
		id = params[:idcliente]
		estatus = params[:estatus]
		if Cliente.update(id, :estatus => estatus)
			render :text =>'{ "success" : "true"}'
		else
			render :text => '{ "success" : "false"}'
		end
	end

	def edit
		if usuario_signed_in? 
			id = params[:id_cliente]
			@cliente = Cliente.where("id = ? ", id).first
			render "clientes/edit"
		else
			redirect_to root_path
		end	
	end
	def save_edit

		id = params[:cliente_id]

		cliente_edit = Cliente.where(["id = ?", id]).first
		cliente_edit.update(cliente_params)

		
		if ! cliente_edit.usuario.blank?

			perfil = Perfil.where("usuario_id = ?", cliente_edit.usuario_id)

			perfil.each do |per|
			 	perfil = per
			end

			perfil.nombres = cliente_edit.nombres
			perfil.apellidos = cliente_edit.apellidos
			perfil.sexo = cliente_edit.sexo
			perfil.save
		end
		
		redirect_to :controller => 'clientes', :action => 'consultar'

	end

	def show
		if !usuario_signed_in?
        	redirect_to root_path
     	else
     		id = params[:id_cliente]
			@cliente = Cliente.where("id = ? ", id).first
			if !@cliente.usuario.blank?
				@usuredes = UsuarioRedSocial.includes(:red_social).where("usuario_id = ?", @cliente.usuario.id)
			end
			render "clientes/show"
        end
	end

	def eliminar
		id = params[:idcliente]
		cliente = Cliente.where(id: id).first
		cliente.destroy
      if cliente.destroyed?
      	render :text =>'{ "success" : "true"}'
	  else
		render :text => '{ "success" : "false"}'
	   end
	end

	private
		def cliente_params
	      accessible = [ :nombres, :apellidos, :telefono, :telefono_movil, :email, :sexo, :direccion, :tipo_cliente_id, :pais_id ] # extend with your own params
	      params.require(:cliente).permit(accessible)
	    end
end

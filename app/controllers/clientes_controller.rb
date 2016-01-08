class ClientesController < ApplicationController

	def new
		if !usuario_signed_in?
			
		else
			@cliente = cliente.new
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
			id = params[:idcliente]
			@cliente = Cliente.where("id = ? ", id)
			render "clientes/edit"
		else
			redirect_to root_path
		end	
	end

	private
		def cliente_params
	      accessible = [ :nombre, :descripcion ] # extend with your own params
	      params.require(:cliente).permit(accessible)
	    end
end

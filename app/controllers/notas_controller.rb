class NotasController < ApplicationController

	def notas
		if !usuario_signed_in?
			redirect_to root_path
		else
			#nota = Evento.new
			@notas = Notum.where("usuario_id = ?", current_usuario.id).order('id ASC').page(params[:page]).per(9)
			render "/notas/notas"
		end
	end
	
	def create
	   	titulo = params[:titulo]
		contenido = params[:contenido]
		color=params[:color]
	  	@nota = Notum.new
	   	@nota.titulo = titulo
	   	@nota.contenido = contenido
	   	@nota.color = color
	   	@nota.usuario_id = current_usuario.id
	   	if @nota.save
	   		render :text =>'{ "success" : "true"}'
	  	else
			render :text => '{ "success" : "false"}'
	   	end
	end

	def update
		id = params[:idnota]
		titulo = params[:titulo]
		contenido = params[:contenido]
		color = params[:color]
		if Notum.update(id, :titulo => titulo, :contenido => contenido, :color => color)
			render :text =>'{ "success" : "true"}'
		else

			render :text => '{ "success" : "false"}'
		end
	end

	def eliminar
		id = params[:idnota]
		nota = Notum.where(id: id).first
		nota.destroy
		if nota.destroyed?
			render :text =>'{ "success" : "true"}'
	  	else
			render :text => '{ "success" : "false"}'
	   	end
	end

	def consultar
		id = params[:idnota]
		@nota = Notum.where(id: id).first
		render :json => @nota
	end
end

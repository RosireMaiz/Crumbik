class TemasController < ApplicationController

	def consultar
		render "temas/temas"
	end

	def new
		if !usuario_signed_in?
			redirect_to root_path
		else
			if request.subdomain.present?
				redirect_to root_path
			else
				@tema = Tema.new
				formato_imagen = "data:image/png;base64,"
    			imagen = Base64.encode64(File.open($IMAGEN_DEFAULT, "rb").read)
    			@tema.formato_imagen = formato_imagen
    			@tema.imagen = imagen
				render "temas/new"
			end
		end
		
	end

	def create
		tema = Tema.new(tema_params)
	    tema.save
	  	redirect_to :controller => 'temas', :action => 'consultar'
	end

	def edit
		if !usuario_signed_in?
			redirect_to root_path
		else
			if request.subdomain.present?
				redirect_to root_path
			else
				id = params[:id_tema]
				@tema = Tema.where("id = ?", id).first	
				render "temas/edit"
			end
		end
		
	end

	def save_edit
		id = params[:tema][:id]

		tema_edit = Tema.where(["id = ?", id]).first
		
		tema_edit.update(tema_params)

		redirect_to :controller => 'temas', :action => 'consultar'
	end

	def delete
		id = params[:idtema]
		tema = Tema.where(id: id).first
		tema.destroy
      if tema.destroyed?
      	render :text =>'{ "success" : "true"}'
	  else
		render :text => '{ "success" : "false"}'
	   end
	end

	private
	 def tema_params
      accessible = [ :nombre, :descripcion,  :formato_imagen, :imagen ] # extend with your own params
      params.require(:tema).permit(accessible)
    end
end

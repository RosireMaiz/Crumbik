class NotasController < ApplicationController
	def notas
		if !usuario_signed_in?
			redirect_to root_path
		else
			#nota = Evento.new
			#@notas = nota.buscar_notas(current_usuario.id)
			render "/notas/notas"
		end
	end
end

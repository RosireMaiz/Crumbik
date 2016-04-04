class Interaccion < ActiveRecord::Base
	enum tipo_interaccion: [:compartir, :puntuacion, :me_gusta, :comentario]
	belongs_to :producto, class_name: "Producto"
	belongs_to :usuario, class_name: "Usuario"
end

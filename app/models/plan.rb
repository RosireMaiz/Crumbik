class Plan < ActiveRecord::Base
	belongs_to :frecuencia_pago, class_name: "FrecuenciaPago"
	has_many :plan_servicio, class_name: "PlanServicio"
	has_many :servicio, :through => :plan_servicio

	def count_total_comentarios
		comentarios ||= Array.new
		date = Date.today.strftime("%Y")
		(1..12).each do |i|
			puntuacion = Interaccion.where("tipo_interaccion = ? AND extract(year  from created_at) = ? AND extract(month from created_at) = ?", Interaccion.tipo_interaccions["comentario"], date, i).length
			comentarios.push(puntuacion)
		end
		comentarios	
	end

	def count_total_me_gusta
		me_gusta ||= Array.new
		date = Date.today.strftime("%Y")
		(1..12).each do |i|
			puntuacion = Interaccion.where("tipo_interaccion = ? AND extract(year  from created_at) = ? AND extract(month from created_at) = ?", Interaccion.tipo_interaccions["me_gusta"], date, i).length
			me_gusta.push(puntuacion)
		end
		me_gusta	
	end

	def count_total_compartir
		me_gusta ||= Array.new
		date = Date.today.strftime("%Y")
		(1..12).each do |i|
			puntuacion = Interaccion.where("tipo_interaccion = ? AND extract(year  from created_at) = ? AND extract(month from created_at) = ?", Interaccion.tipo_interaccions["compartir"], date, i).length
			me_gusta.push(puntuacion)
		end
		me_gusta
	end

	def average_puntuacion
		averages ||= Array.new
		date = Date.today.strftime("%Y")
		(1..12).each do |i|
			puntuacion = Interaccion.where("tipo_interaccion = ? AND extract(year  from created_at) = ? AND extract(month from created_at) = ?", Interaccion.tipo_interaccions["puntuacion"], date, i).average(:contenido)
			averages.push(puntuacion.to_i)
		end
		averages
	end


	def count_total_comentarios_producto(producto_id)
		comentarios ||= Array.new
		date = Date.today.strftime("%Y")
		(1..12).each do |i|
			puntuacion = Interaccion.where("producto_id = ?  AND tipo_interaccion = ? AND extract(year  from created_at) = ? AND extract(month from created_at) = ?", producto_id, Interaccion.tipo_interaccions["comentario"], date, i).length
			comentarios.push(puntuacion)
		end
		comentarios	
	end

	def count_total_me_gusta_producto(producto_id)
		me_gusta ||= Array.new
		date = Date.today.strftime("%Y")
		(1..12).each do |i|
			puntuacion = Interaccion.where("producto_id = ?  AND tipo_interaccion = ? AND extract(year  from created_at) = ? AND extract(month from created_at) = ?", producto_id, Interaccion.tipo_interaccions["me_gusta"], date, i).length
			me_gusta.push(puntuacion)
		end
		me_gusta	
	end

	def count_total_compartir_producto(producto_id)
		me_gusta ||= Array.new
		date = Date.today.strftime("%Y")
		(1..12).each do |i|
			puntuacion = Interaccion.where("producto_id = ?  AND tipo_interaccion = ? AND extract(year  from created_at) = ? AND extract(month from created_at) = ?", producto_id, Interaccion.tipo_interaccions["compartir"], date, i).length
			me_gusta.push(puntuacion)
		end
		me_gusta
	end

	def average_puntuacion_producto(producto_id)
		averages ||= Array.new
		date = Date.today.strftime("%Y")
		(1..12).each do |i|
			puntuacion = Interaccion.where("producto_id = ?  AND tipo_interaccion = ? AND extract(year  from created_at) = ? AND extract(month from created_at) = ?", producto_id, Interaccion.tipo_interaccions["puntuacion"], date, i).average(:contenido)
			averages.push(puntuacion.to_i)
		end
		averages
	end

end

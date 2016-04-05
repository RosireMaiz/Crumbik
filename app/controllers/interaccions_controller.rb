class InteraccionsController < ApplicationController
	def consultar
		if !usuario_signed_in?
			redirect_to root_path
		else
			if !request.subdomain.present?
				@comentarios_count = Plan.new.count_total_comentarios
				@like_count = Plan.new.count_total_me_gusta
				@average_count = Plan.new.average_puntuacion
				@share_count = Plan.new.count_total_compartir

			else

				@comentarios_count = Producto.new.count_total_comentarios
				@like_count = Producto.new.count_total_me_gusta
				@average_count = Producto.new.average_puntuacion
				@share_count = Producto.new.count_total_compartir
				
			end
			@difusiones_count = CampannaPublicitarium.new.cantidad_difusion_general
			render "interaccions/interaccions_general"
		end
	end

	def consultar_producto
		if !usuario_signed_in?
			redirect_to root_path
		else
			id_producto = params[:id_producto]
			@producto = Producto.where(id: id_producto).first
			@comentarios_count = Producto.new.count_total_comentarios_producto(id_producto)
			@like_count = Producto.new.count_total_me_gusta_producto(id_producto)
			@average_count = Producto.new.average_puntuacion_producto(id_producto)
			@share_count = Producto.new.count_total_compartir_producto(id_producto)
			@difusiones_count = CampannaPublicitarium.new.cantidad_difusion_producto(id_producto)
			render "interaccions/interaccions_general"
		end
	end

	def consultar_plan
		if !usuario_signed_in?
			redirect_to root_path
		else
			id_plan = params[:idplan]
			@producto = Plan.where(id: id_producto).first
			@comentarios_count = Plan.new.count_total_comentarios_producto(id_plan)
			@like_count = Plan.new.count_total_me_gusta_producto(id_plan)
			@average_count = Plan.new.average_puntuacion_producto(id_plan)
			@share_count = Plan.new.count_total_compartir_producto(id_plan)
			@difusiones_count = CampannaPublicitarium.new.cantidad_difusion_producto(id_plan)
			render "interaccions/interaccions_general"
		end
		
	end
end

class InteraccionCampannaPubsController < ApplicationController

	def new_difusion
		if !usuario_signed_in?
			redirect_to root_path
		else
			id = params[:id_campanna_publicitaria]
			@campanna_publicitaria = CampannaPublicitarium.where("id = ?", id).first	

			@interaccionCampannaPub = InteraccionCampannaPub.new


			tabla = "perfils"
			sql = "Select usuario_id from "+ tabla.to_s+" where sexo = 'femenino' "
			records_array = ActiveRecord::Base.connection.execute(sql)
     		ids =[]
     		records_array.each do |row|
				ids =row[0].to_s
			end
         	@usuarios = Usuario.where("id IN (?)", ids).page(params[:page]).per(9)

			#@usuarios = Usuario.order('id ASC')
		end
		
	end
end

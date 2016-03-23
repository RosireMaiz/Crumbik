class CampannaPublicitariasController < ApplicationController

	def dashboard_campanna
		if !usuario_signed_in?
        	redirect_to root_path
     	else
	        @campanna_publicitarias = CampannaPublicitarium.order('id ASC')
	        render "campanna_publicitarias/campanna_publicitarias"	
     	end
	end

	def new
		if !usuario_signed_in?
			redirect_to root_path
		else
			@campanna_publicitaria = CampannaPublicitarium.new
			render "campanna_publicitarias/new"
		end
	end
end

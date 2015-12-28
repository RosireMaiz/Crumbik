class PortalController < ApplicationController
	
	def index
		if usuario_signed_in?
			if !$administrable
				if request.subdomain.present?
		        	render "organizacions/index"
			    else
			       	render "portal/index"	
			    end
			else
				render "portal/index_principal"
			end
		else
			if request.subdomain.present?
        		render "organizacions/index"
	    	else
	       		render "portal/index"	
	      	end
		end
	end

	def index_inicio
		$administrable = false
		if request.subdomain.present?
        	render "organizacions/index"
	    else
	       	render "portal/index"	
	    end
	end

	def index_administrable
		$administrable = true
		organizacion = Organizacion.where("usuario_id = ?", current_usuario.id)
		if organizacion.length > 0
			redirect_to "http://" + organizacion.first.subdominio + ".lvh.me:3000"
		else
			render "portal/index_principal"
		end
		
	end

end
class PortalController < ApplicationController
	
	def index
		if usuario_signed_in?
			if !current_usuario.current_administrable
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
		if usuario_signed_in?
			$administrable = false
			usuario = current_usuario
		    usuario.current_administrable = false
		    usuario.save
			if request.subdomain.present?
	        	render "organizacions/index"
		    else
		       	render "portal/index"	
		    end
	    else
	    	if request.subdomain.present?
	        	render "organizacions/index"
		    else
		       	render "portal/index"	
		    end
	    end

	end

	def index_administrable
		$administrable = true
		usuario = current_usuario
	    usuario.current_administrable = true
	    usuario.save
		#organizacion = Organizacion.where("usuario_id = ?", usuario.id)
		render "portal/index_principal"
	end
	def desarrolladores
		render "portal/desarrolladores"
	end

end
class PortalController < ApplicationController
	
	def index
		if usuario_signed_in?
			render "portal/index"
		else
			if request.subdomain.present?
        		render "organizacions/index"
	    	else
	       		render "portal/index"	
	      	end
		end

	end

end
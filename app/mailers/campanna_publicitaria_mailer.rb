class CampannaPublicitariaMailer < ApplicationMailer
	  default from: "from@example.com"

	def email_difusion(asunto, mensaje, email)
		@email = email
    	@mensaje  = mensaje
    	mail(from: 'no-reply@example.com',to: @email, content_type: "text/html", subject: asunto, body: @mensaje)	
	end
end

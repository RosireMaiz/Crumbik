class EventosController < ApplicationController

	def create
	   	titulo = params[:titulo]
		descripcion = params[:descripcion]
		inicio = params[:inicio]
		fin = params[:fin]
	  	@evento = Evento.new
	   	@evento.titulo = titulo
	   	@evento.descripcion = descripcion
	   	@evento.inicio = inicio
	   	@evento.fin = fin
	   	@evento.usuario_id = current_usuario.id
	   	if @evento.save
	   		render :text =>'{ "success" : "true"}'
	  	else
			render :text => '{ "success" : "false"}'
	   	end
	end


	def cancelar
		id = params[:idevento]
		@evento = Evento.where(id: id).first
		render :json => @evento
	end	

	def eliminar
		id = params[:idevento]
		evento = Evento.where(id: id).first
		evento.destroy
		if evento.destroyed?
			render :text =>'{ "success" : "true"}'
	  	else
			render :text => '{ "success" : "false"}'
	 	end
	end

	def update
		id = params[:idevento]
		titulo = params[:titulo]
		descripcion = params[:descripcion]
		inicio = params[:inicio]
		fin = params[:fin]
		if Evento.update(id, :titulo => titulo, :descripcion => descripcion, :inicio => inicio, :fin => fin)
			render :text =>'{ "success" : "true"}'
		else
			render :text => '{ "success" : "false"}'
		end
	end

	def calendario
		#@alert_message = "Hola Mundo SMS =D"
		#phone_number = '+584165528455'
		#send_message(phone_number, @alert_message)
		if !usuario_signed_in?
			redirect_to root_path
		else
			evento = Evento.new
			@eventos = evento.buscar_eventos(current_usuario.id)
			render "/eventos/calendar"
		end
	end

	def eventos
		if !usuario_signed_in?
			redirect_to root_path
		else

			evento = Evento.new
			@eventos = evento.buscar_eventos(current_usuario.id)
			respond_to do |format| 
		      format.html
		      format.json { render :json => @eventos } 
		    end
		end
	end

	def send_message(phone_number, alert_message)

    	require 'rubygems' # not necessary with ruby 1.9 but included for completeness 
		require 'twilio-ruby' 
		 
		# put your own credentials here 
		account_sid = 'ACc6b076d941741f47e46dfe041bd98eed' 
		auth_token = '4a8218fbf947e1865c470f7e2cb0d70c' 
		 
		# set up a client to talk to the Twilio REST API 
		@client = Twilio::REST::Client.new account_sid, auth_token 
		 
		message = @client.account.messages.create({
			:from => '+18594485515', 
			:to => '+584149552967', 
			:body => 'Hola Mundo SMS =D',  
		})

      	puts message.to
    end

    private
	 def evento_params
      accessible = [ :titulo,:descripcion, :inicio , :fin, :dia_completo ] # extend with your own params
      params.require(:evento).permit(accessible)
    end
 
end

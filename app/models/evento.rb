class Evento < ActiveRecord::Base
	belongs_to :usuario, class_name: "usuario", foreign_key: "usuario_id"

	def buscar_eventos(usuario_id)
		event = Evento.where("usuario_id = ?", usuario_id) 
  		#event = "{ title: " + "inicio" +", start: " + "2016-02-16" +"}, { title: " + "inicio" +", start: " + "2016-02-16" +"}"
        return event
  	end

  	 def as_json(options = {})
    {
      :id => self.id,
      :title => self.titulo,
      :start => self.inicio.rfc822,
      :end => self.fin.rfc822,
      :allDay =>  self.dia_completo,
      :description =>  self.descripcion,
      #:user_name => self.user_name,
      #:url => Rails.application.routes.url_helpers.events_path(id),
      	:color => self.color
      
    }
  end
end


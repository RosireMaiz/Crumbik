class Pais < ActiveRecord::Base
	has_many :organizacion, :inverse_of=>:pais
	def nombre_codigo_telefono
    "#{nombre} (+#{codigo_telefono})"
  end
end

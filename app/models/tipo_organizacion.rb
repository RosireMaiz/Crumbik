class TipoOrganizacion < ActiveRecord::Base
	has_many :organizacion, :inverse_of=>:tipo_organizacion
end

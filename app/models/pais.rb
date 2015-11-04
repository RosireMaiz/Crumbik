class Pais < ActiveRecord::Base
	has_many :organizacion, :inverse_of=>:pais
end

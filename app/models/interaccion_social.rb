class InteraccionSocial < ActiveRecord::Base
	belongs_to :organizacion_red_social, foreign_key: "organizacion_red_social_id"
  	belongs_to :publicidad, foreign_key: "publicidad_id"
  	has_many :publicacion_social
end

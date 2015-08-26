class OpcionMenu < ActiveRecord::Base
	belongs_to :menu, class_name: "Menu", foreign_key: "menu_id"
	has_many :hijos, class_name: "OpcionMenu", foreign_key: "padre_id"
	belongs_to :padre, class_name: "OpcionMenu"
	default_scope { order('orden ASC') }	
end

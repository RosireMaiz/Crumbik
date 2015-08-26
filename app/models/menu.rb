class Menu < ActiveRecord::Base
	belongs_to :rol
	has_many :opcionmenu, class_name: "OpcionMenu"
end

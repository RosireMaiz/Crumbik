class Categorium < ActiveRecord::Base
	has_many :variable_categorium, class_name: "VariableCategorium", foreign_key: "categoria_id"
  	has_many :variable_psicografica, :through => :variable_categorium,  foreign_key: "categoria_id"
end
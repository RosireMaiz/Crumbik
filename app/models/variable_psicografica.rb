class VariablePsicografica < ActiveRecord::Base
  	has_many :variable_categorium, class_name: "VariableCategorium"
  	has_many :categorium, :through => :variable_categorium

  	has_many :variable_usuario, class_name: "VariableUsuario"
  	has_many :usuario, :through => :variable_usuario
end
class VariableUsuario < ActiveRecord::Base
	belongs_to :usuario, foreign_key: "usuario_id"
  	belongs_to :variable_psicografica, foreign_key: "variable_psicografica_id"
end

class VariableCategorium < ActiveRecord::Base
	belongs_to :categorium, foreign_key: "categoria_id"
  	belongs_to :variable_psicografica, foreign_key: "variable_psicografica_id"
end
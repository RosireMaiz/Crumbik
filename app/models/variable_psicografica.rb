class VariablePsicografica < ActiveRecord::Base
  	has_many :variable_categorium, class_name: "VariableCategorium"
  	has_many :categorium, :through => :variable_categorium
end
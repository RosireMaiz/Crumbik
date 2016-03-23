class CreateVariableCategoria < ActiveRecord::Migration
  def change
    create_table :variable_categoria do |t|
    	t.references :categoria, index: true
      	t.references :variable_psicografica, index: true

      	t.timestamps null: false
    end
  end
end

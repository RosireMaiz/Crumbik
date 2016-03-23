class CreateVariableUsuarios < ActiveRecord::Migration
  def change
    create_table :variable_usuarios do |t|

      t.references :variable_psicografica, index: true
      t.references :usuario, index: true
      
      t.timestamps null: false
      
    end
  end
end

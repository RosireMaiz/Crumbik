class CreateVariablePsicograficas < ActiveRecord::Migration
  def change
    create_table :variable_psicograficas do |t|
      t.string :nombre
      t.text :descripcion
      t.string :estatus, default: "A", :limit => 1
    end
  end
end

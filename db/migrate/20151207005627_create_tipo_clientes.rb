class CreateTipoClientes < ActiveRecord::Migration
  def change
    create_table :tipo_clientes do |t|
      t.string :nombre
      t.string :descripcion
  	  t.string :estatus, default: "A", :limit => 1    end
  end
end

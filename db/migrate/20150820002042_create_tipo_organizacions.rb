class CreateTipoOrganizacions < ActiveRecord::Migration
  def change
    create_table :tipo_organizacions do |t|
      t.string :nombre
      t.string :descripcion
      t.string :estatus, default: "A", :limit => 1

      t.timestamps null: false
    end
  end
end

class CreatePais < ActiveRecord::Migration
  def change
    create_table :pais do |t|
      t.string :iso, default: "A", :limit => 3
      t.string :nombre
      t.string :nicename
      t.string :iso3, default: "A", :limit => 3
      t.string :numcode, default: "A", :limit => 3
      t.integer :codigo_telefono, null: false, :limit => 5
 	  t.string :estatus, default: "A", :limit => 1
    end
  end
end

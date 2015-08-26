class CreateRedSocials < ActiveRecord::Migration
  def change
    create_table :red_socials do |t|
      t.string :icono
      t.string :nombre
      t.string :estatus, default: "A", :limit => 1

    end
  end
end

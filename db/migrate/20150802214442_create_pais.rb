class CreatePais < ActiveRecord::Migration
  def change
    create_table :pais do |t|
      t.string :iso, default: "A", :limit => 3
      t.string :nombre

    end
  end
end

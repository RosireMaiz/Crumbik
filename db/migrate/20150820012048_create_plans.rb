class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :nombre
      t.string :descripcion
      t.string :estatus, default: "A", :limit => 1

    end
  end
end

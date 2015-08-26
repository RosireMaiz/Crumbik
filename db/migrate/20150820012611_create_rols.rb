class CreateRols < ActiveRecord::Migration
  def change
    create_table :rols do |t|
      t.string :nombre
      t.string :estatus, default: "A", :limit => 1

    end
  end
end

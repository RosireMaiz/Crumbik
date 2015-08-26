class CreatePais < ActiveRecord::Migration
  def change
    create_table :pais do |t|
      t.string :nombre

    end
  end
end

class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
    	t.integer :tipo_menu, default: 0
 		t.references :rol, index: true

		t.timestamps null: false
    end
  end
end

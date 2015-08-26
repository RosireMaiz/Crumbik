class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
 		t.references :rol,			 index: true
 		t.references :opcion_menu, 	 index: true
      	t.timestamps null: false
    end
  end
end

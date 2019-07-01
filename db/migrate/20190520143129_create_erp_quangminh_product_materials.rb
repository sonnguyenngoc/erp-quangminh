class CreateErpQuangminhProductMaterials < ActiveRecord::Migration[5.1]
  def change
    create_table :erp_quangminh_product_materials do |t|
      t.string :name
      t.string :description
      t.references :creator, index: true, references: :erp_users

      t.timestamps
    end
  end
end
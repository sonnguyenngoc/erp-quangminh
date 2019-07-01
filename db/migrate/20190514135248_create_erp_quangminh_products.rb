class CreateErpQuangminhProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :erp_quangminh_products do |t|
      t.string :code
      t.string :name
      t.decimal :price, default: 1000
      t.boolean :is_sale, default: false
      t.decimal :sale_price
      t.integer :sale_precent
      t.boolean :is_new, default: false
      t.boolean :is_bestseller, default: false
      t.boolean :show_price, default: true
      t.boolean :is_eol, default: false
      t.string :description
      t.string :meta_keywords
      t.string :meta_description
      t.string :alias
      t.integer :custom_order
      t.integer :stock
      t.references :product_category, index: true, references: :erp_quangminh_product_categories
      t.references :product_brand, index: true, references: :erp_quangminh_product_brands
      t.references :product_material, index: true, references: :erp_quangminh_product_materials
      t.references :creator, index: true, references: :erp_users

      t.timestamps
    end
  end
end

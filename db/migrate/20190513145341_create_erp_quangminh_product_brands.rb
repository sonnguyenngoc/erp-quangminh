class CreateErpQuangminhProductBrands < ActiveRecord::Migration[5.1]
  def change
    create_table :erp_quangminh_product_brands do |t|
      t.string :image_url
      t.string :name
      t.string :description
      t.string :meta_keywords
      t.string :meta_description
      t.string :alias
      t.integer :custom_order      
      t.references :creator, index: true, references: :erp_users

      t.timestamps
    end
  end
end

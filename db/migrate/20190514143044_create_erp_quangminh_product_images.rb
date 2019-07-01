class CreateErpQuangminhProductImages < ActiveRecord::Migration[5.1]
  def change
    create_table :erp_quangminh_product_images do |t|
      t.string :image_url
      t.references :product, index: true, references: :erp_quangminh_products

      t.timestamps
    end
  end
end

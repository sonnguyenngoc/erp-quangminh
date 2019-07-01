class CreateErpQuangminhBlogs < ActiveRecord::Migration[5.1]
  def change
    create_table :erp_quangminh_blogs do |t|
      t.string :image_url
      t.string :name
      t.string :alias
      t.text :content
      t.string :meta_keywords
      t.string :meta_description
      t.integer :custom_order
      t.string :tags
      t.references :blog_category, index: true, references: :erp_quangminh_blog_categories
      t.references :creator, index: true, references: :erp_users

      t.timestamps
    end
  end
end
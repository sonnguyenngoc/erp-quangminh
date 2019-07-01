module Erp
  module Quangminh
    module ApplicationHelper
      
      def category_link(category)
        erp_quangminh.product_listing_path(category_id: category.id, alias: category.alias)
      end
      
      def product_link(category, product)
        erp_quangminh.product_detail_path(category_id: category.id, category_alias: category.alias,
                                          product_id: product.id, product_alias: product.alias)
      end
      
    end
  end
end

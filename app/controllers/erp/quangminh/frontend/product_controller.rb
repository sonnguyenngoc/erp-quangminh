module Erp
  module Quangminh
    module Frontend
      class ProductController < Erp::Frontend::FrontendController
        def listing
          @body_style = 'template-collection'
          @category = Erp::Quangminh::ProductCategory.find(params[:category_id])
          @products = @category.get_products_for_categories(params).paginate(:page => params[:page], :per_page => 12)
        end
        
        def detail
          @body_style = 'template-product'
          @category = Erp::Quangminh::ProductCategory.find(params[:category_id])
          @product = Erp::Quangminh::Product.find(params[:product_id])
        end
      end
    end
  end
end
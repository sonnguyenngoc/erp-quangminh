module Erp
  module Quangminh
    module Frontend
      class ProductController < Erp::Frontend::FrontendController
        def listing
          @body_style = 'template-collection'
        end
        
        def detail
          @body_style = 'template-product'
        end
      end
    end
  end
end
module Erp
  module Quangminh
    module Frontend
      class BlogController < Erp::Frontend::FrontendController
        def listing
          @body_style = 'template-blog'
        end
        
        def detail
          @body_style = 'template-article'
        end        
      end
    end
  end
end
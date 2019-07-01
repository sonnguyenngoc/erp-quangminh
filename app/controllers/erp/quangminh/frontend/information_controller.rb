module Erp
  module Quangminh
    module Frontend
      class InformationController < Erp::Frontend::FrontendController
        def about_us
          @body_style = 'template-page'
        end
        
        def contact_us
          @body_style = 'template-page'
        end
        
        def shopping_guide
          @body_style = 'template-article'
        end
        
        def payment_method
          @body_style = 'template-article'
        end
        
        def delivery_method
          @body_style = 'template-article'
        end
        
        def return_policy
          @body_style = 'template-article'
        end
        
        def privacy_policy
          @body_style = 'template-article'
        end
        
        def shopping_guide
          @body_style = 'template-article'
        end
        
        def payment_method
          @body_style = 'template-article'
        end
        
        def delivery_method
          @body_style = 'template-article'
        end
        
        def return_policy
          @body_style = 'template-article'
        end
        
        def faqs
        end
      end
    end
  end
end
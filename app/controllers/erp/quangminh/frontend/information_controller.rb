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
      end
    end
  end
end
module Erp
  module Quangminh
    module Frontend
      class ComingController < Erp::Frontend::FrontendController
        layout 'erp/frontend/coming'
        
        def index
        end
        
        def not_found          
          render(:status => 404)
        end
      end
    end
  end
end
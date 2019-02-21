module Erp
  module Quangminh
    module Frontend
      class ComingController < Erp::Frontend::FrontendController
        def index
          render :layout => 'erp/frontend/coming'
        end
        def not_found          
          render(:status => 404)
          render :layout => 'erp/frontend/coming'
        end
      end
    end
  end
end
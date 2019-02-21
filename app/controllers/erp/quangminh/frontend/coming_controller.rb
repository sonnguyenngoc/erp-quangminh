module Erp
  module Quangminh
    module Frontend
      class ComingController < Erp::Frontend::FrontendController
        def index
          render :layout => 'erp/frontend/coming'
        end
        def not_found          
          render(:status => 404)
          redirect_to erp_hoanmy.root_path
        end
      end
    end
  end
end
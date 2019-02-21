module Erp
  module Quangminh
    module Frontend
      class ComingController < Erp::Frontend::FrontendController
        def index
          render :layout => 'erp/frontend/coming'
        end
      end
    end
  end
end
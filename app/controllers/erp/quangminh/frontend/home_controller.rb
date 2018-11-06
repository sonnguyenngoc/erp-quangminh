module Erp
  module Quangminh
    module Frontend
      class HomeController < Erp::Frontend::FrontendController
        def index
          @body_style = 'template-index'
        end
      end
    end
  end
end
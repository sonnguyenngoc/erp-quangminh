Erp::Quangminh::Engine.routes.draw do
    root to: "frontend/home#index"
    
    get "gioi-thieu-do-go-viet-quang-minh.html" => "frontend/information#about_us", as: :about_us
    get "lien-he-do-go-viet-quang-minh.html" => "frontend/information#contact_us", as: :contact_us
    
    get "huong-dan-mua-hang.html" => "frontend/information#shopping_guide", as: :shopping_guide
    get "phuong-thuc-thanh-toan.html" => "frontend/information#payment_method", as: :payment_method
    get "cach-thuc-giao-nhan.html" => "frontend/information#delivery_method", as: :delivery_method    
    get "chinh-sach-doi-tra.html" => "frontend/information#return_policy", as: :return_policy
    get "chinh-sach-bao-mat.html" => "frontend/information#privacy_policy", as: :privacy_policy
    get "cau-hoi-thuong-gap.html" => "frontend/information#faqs", as: :faqs
    
    get "danh-sach(/:category_id)(-:alias).html" => "frontend/product#listing", as: :product_listing
    get "san-pham(/:category_id)(-:category_alias)(/:product_id)(-:product_alias).html" => "frontend/product#detail", as: :product_detail
    
    get "danh-sach-tin.html" => "frontend/blog#listing", as: :blog_listing
    get "danh-sach/chi-tiet.html" => "frontend/blog#detail", as: :blog_detail
    
    scope "(:locale)", locale: /en|vi/ do
        namespace :backend, module: "backend", path: "quangminh/backend" do
            resources :products do
                collection do
                  post 'list'
                  get 'dataselect'
                  put 'move_up'
                  put 'move_down'
                end
            end
            
            resources :product_categories do
                collection do
                  post 'list'
                  get 'dataselect'
                  put 'move_up'
                  put 'move_down'
                end
            end
            
            resources :product_brands do
                collection do
                  post 'list'
                  get 'dataselect'
                  put 'move_up'
                  put 'move_down'
                end
            end
            
            resources :product_materials do
                collection do
                  post 'list'
                  get 'dataselect'
                end
            end
            
            resources :blog_categories do
                collection do
                  post 'list'
                  get 'dataselect'
                  put 'move_up'
                  put 'move_down'
                end
            end
            
            resources :blogs do
                collection do
                  post 'list'
                  get 'dataselect'
                  put 'move_up'
                  put 'move_down'
                end
            end
        end
    end
end
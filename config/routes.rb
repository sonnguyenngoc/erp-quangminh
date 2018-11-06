Erp::Quangminh::Engine.routes.draw do
    root to: "frontend/home#index"
    
    get "gioi-thieu.html" => "frontend/information#about_us", as: :about_us
    get "lien-he.html" => "frontend/information#contact_us", as: :contact_us
    
    get "danh-sach-san-pham.html" => "frontend/product#listing", as: :product_listing
    get "danh-sach-san-pham/chi-tiet-san-pham.html" => "frontend/product#detail", as: :product_detail
    
    get "tin-tuc.html" => "frontend/blog#listing", as: :blog_listing
    get "tin-tuc/chi-tiet.html" => "frontend/blog#detail", as: :blog_detail
end
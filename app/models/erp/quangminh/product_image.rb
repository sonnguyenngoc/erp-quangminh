module Erp::Quangminh
  class ProductImage < ApplicationRecord
    mount_uploader :image_url, Erp::Quangminh::ProductImageUploader
    belongs_to :product, class_name: "Erp::Quangminh::Product", optional: true
  end
end

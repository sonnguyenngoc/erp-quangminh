module Erp::Quangminh
  class Product < ApplicationRecord
		belongs_to :product_material, class_name: "Erp::Quangminh::ProductMaterial"
    belongs_to :product_category, class_name: "Erp::Quangminh::ProductCategory"
    belongs_to :product_brand, class_name: "Erp::Quangminh::ProductBrand"
    belongs_to :creator, class_name: "Erp::User"
    
    validates :name, :presence => true
    validates :code, :presence => true
    validates :code, uniqueness: true
    
    has_many :product_images, class_name: "Erp::Quangminh::ProductImage", dependent: :destroy
    accepts_nested_attributes_for :product_images, :reject_if => lambda { |a| a[:image_url].blank? and a[:image_url_cache].blank? }, :allow_destroy => true
    
    after_save :destroy_images_url_nil?
    def destroy_images_url_nil?
			self.product_images.where(image_url: nil).destroy_all
		end
    
    include Erp::CustomOrder
    
    after_create :create_alias
    
    def create_alias
			name = self.name
			self.update_column(:alias, name.to_ascii.downcase.to_s.gsub(/[^0-9a-z ]/i, '').gsub(/ +/i, '-').strip)
		end
    
    def price=(price)
      self[:price] = price.to_s.gsub(/\,/, '')
    end
    
    def self.filter(query, params)
      params = params.to_unsafe_hash
      and_conds = []
			
			#filters
			if params["filters"].present?
				params["filters"].each do |ft|
					or_conds = []
					ft[1].each do |cond|
						# in case filter is show archived
						if cond[1]["name"] == 'show_archived'
							# show archived items
							show_archived = true
						else
							or_conds << "#{cond[1]["name"]} = '#{cond[1]["value"]}'"
						end
					end
					and_conds << '('+or_conds.join(' OR ')+')' if !or_conds.empty?
				end
			end
      
      #keywords
      if params["keywords"].present?
        params["keywords"].each do |kw|
          or_conds = []
          kw[1].each do |cond|
            or_conds << "LOWER(#{cond[1]["name"]}) LIKE '%#{cond[1]["value"].downcase.strip}%'"
          end
          and_conds << '('+or_conds.join(' OR ')+')'
        end
      end
      
      if params[:category_id].present?
					category = Erp::Quangminh::ProductCategory.find(params[:category_id])
					query = query.where(product_category_id: category.get_all_related_category_ids)
			end
      
      # join with users table for search creator
      query = query.joins(:creator)
			
      query = query.where(and_conds.join(' AND ')) if !and_conds.empty?      
      
      return query
    end
    
    def self.search(params)
      query = self.all
      query = self.filter(query, params)
      
      # order
      if params[:sort_by].present?
        order = params[:sort_by]
        order += " #{params[:sort_direction]}" if params[:sort_direction].present?
        
        query = query.order(order)
      end
      
      return query
    end
    
    # data for dataselect ajax
    def self.dataselect(keyword='')
      query = self.all
      
      if keyword.present?
        keyword = keyword.strip.downcase
        query = query.where('LOWER(name) LIKE ?', "%#{keyword}%")
      end
      
      query = query.limit(20).map{|product| {value: product.id, text: product.name} }
    end
    
    def product_material_name
			product_material.present? ? product_material.name : ''
		end
    
    def product_category_name
			product_category.present? ? product_category.full_name : ''
		end
    
    def product_brand_name
			product_brand.present? ? product_brand.full_name : ''
		end
    
    def full_name
      self.name
    end
    
  end
end

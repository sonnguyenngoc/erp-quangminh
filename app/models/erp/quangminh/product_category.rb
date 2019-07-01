module Erp::Quangminh
  class ProductCategory < ApplicationRecord
    belongs_to :creator, class_name: "Erp::User"
    has_many :products, class_name: "Erp::Quangminh::Product"
    
    belongs_to :parent, class_name: "Erp::Quangminh::ProductCategory", optional: true
    has_many :children, class_name: "Erp::Quangminh::ProductCategory", foreign_key: "parent_id"
    
    validates :name, :presence => true
    
    include Erp::CustomOrder
    
    after_create :create_alias
    
    def create_alias
			name = self.name
			self.update_column(:alias, name.to_ascii.downcase.to_s.gsub(/[^0-9a-z ]/i, '').gsub(/ +/i, '-').strip)
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
      
      # join with users table for search creator
      query = query.joins("LEFT JOIN erp_quangminh_product_categories parents_erp_quangminh_product_categories ON parents_erp_quangminh_product_categories.id = erp_quangminh_product_categories.parent_id")
			
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
      
      query = query.limit(20).map{|product_category| {value: product_category.id, text: product_category.name} }
    end
    
    def self.get_parent_categories
			self.where(parent_id: nil).order("custom_order ASC")
		end

    # display parent name
    def parent_name
			parent.present? ? parent.name : ''
		end
    
    # display self name
    def get_self_name
			self.name
		end
		
		# display name with parent
    def full_name
			names = [self.name]
			p = self.parent
			while !p.nil? do
				names << p.name
				p = p.parent
			end
			names.reverse.join(" / ")
		end
    
    def get_products_for_categories(params)
			records = Erp::Quangminh::Product
									 .where(product_category_id: self.get_self_and_children_ids)
		end
    
    # get self and children ids
    def get_self_and_children_ids
      ids = [self.id]
      ids += get_children_ids_recursive
      return ids.uniq
		end

    # get children ids recursive
    def get_children_ids_recursive
      ids = []
      children.each do |c|
				if !c.children.empty?
					ids += c.get_children_ids_recursive
				end
				ids << c.id
			end
      return ids
		end
    
  end
end

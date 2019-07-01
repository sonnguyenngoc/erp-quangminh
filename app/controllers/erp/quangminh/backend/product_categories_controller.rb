module Erp
  module Quangminh
    module Backend
      class ProductCategoriesController < Erp::Backend::BackendController
        before_action :set_product_category, only: [:move_up, :move_down, :show, :edit, :update, :destroy]
    
        # GET /product_categories
        def list
          @product_categories = ProductCategory.search(params).paginate(:page => params[:page], :per_page => 20)
          
          render layout: nil
        end
        
        # GET /product_categories/new
        def new
          @product_category = ProductCategory.new
          
          if request.xhr?
            render '_form', layout: nil, locals: {product_category: @product_category}
          end
        end
    
        # GET /product_categories/1/edit
        def edit
        end
        
        # POST /product_categories
        def create
          @product_category = ProductCategory.new(product_category_params)
          @product_category.creator = current_user
          
          if @product_category.save
            if request.xhr?
              render json: {
                status: 'success',
                text: @product_category.name,
                value: @product_category.id
              }
            else
              redirect_to erp_quangminh.edit_backend_product_category_path(@product_category), notice: t('.success')
            end
          else
            if params.to_unsafe_hash['format'] == 'json'
              render '_form', layout: nil, locals: {product_category: @product_category}
            else
              render :new
            end            
          end
        end
    
        # PATCH/PUT /product_categories/1
        def update
          if @product_category.update(product_category_params)
            if request.xhr?
              render json: {
                status: 'success',
                text: @product_category.name,
                value: @product_category.id
              }
            else
              redirect_to erp_quangminh.edit_backend_product_category_path(@product_category), notice: t('.success')
            end
          else
            render :edit
          end
        end
    
        # DELETE /product_categories/1
        def destroy
          @product_category.destroy
          
          respond_to do |format|
            format.html { redirect_to erp_quangminh.backend_product_categories_path, notice: t('.success') }
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end
        
        def dataselect
          respond_to do |format|
            format.json {
              render json: ProductCategory.dataselect(params[:keyword])
            }
          end
        end
        
        # Move up /product_categories/up?id=1
        def move_up
          @product_category.move_up

          respond_to do |format|
          format.json {
            render json: {
            }
          }
          end
        end

        # Move down /product_categories/up?id=1
        def move_down
          @product_category.move_down

          respond_to do |format|
          format.json {
            render json: {
            }
          }
          end
        end
        
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_product_category
            @product_category = ProductCategory.find(params[:id])
          end
    
          # Only allow a trusted parameter "white list" through.
          def product_category_params
            params.fetch(:product_category, {}).permit(:name, :meta_description, :meta_keywords, :parent_id)
          end
      end
    end
  end
end
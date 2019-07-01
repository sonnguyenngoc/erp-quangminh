module Erp
  module Quangminh
    module Backend
      class ProductsController < Erp::Backend::BackendController
        before_action :set_product, only: [:move_up, :move_down, :show, :edit, :update, :destroy]
    
        # GET /products
        def list
          @products = Product.search(params).paginate(:page => params[:page], :per_page => 20)
          
          render layout: nil
        end
        
        # GET /products/new
        def new
          @product = Product.new
          
          10.times do
            @product.product_images.build
          end
          
          if request.xhr?
            render '_form', layout: nil, locals: {product: @product}
          end
        end
    
        # GET /products/1/edit
        def edit
          (10 - @product.product_images.count).times do
            @product.product_images.build
          end
        end
        
        # POST /products
        def create
          @product = Product.new(product_params)
          @product.creator = current_user
          
          10.times do
            @product.product_images.build
          end
          
          if @product.save
            if request.xhr?
              render json: {
                status: 'success',
                text: @product.name,
                value: @product.id
              }
            else
              redirect_to erp_quangminh.edit_backend_product_path(@product), notice: t('.success')
            end
          else
            if params.to_unsafe_hash['format'] == 'json'
              render '_form', layout: nil, locals: {product: @product}
            else
              render :new
            end            
          end
        end
    
        # PATCH/PUT /products/1
        def update
          (10 - @product.product_images.count).times do
            @product.product_images.build
          end
          
          
          
          if @product.update(product_params)
            if request.xhr?
              render json: {
                status: 'success',
                text: @product.name,
                value: @product.id
              }
            else
              redirect_to erp_quangminh.edit_backend_product_path(@product), notice: t('.success')
            end
          else
            render :edit
          end
        end
    
        # DELETE /products/1
        def destroy
          @product.destroy
          
          respond_to do |format|
            format.html { redirect_to erp_quangminh.backend_products_path, notice: t('.success') }
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
              render json: Product.dataselect(params[:keyword])
            }
          end
        end
        
        # Move up /products/up?id=1
        def move_up
          @product.move_up

          respond_to do |format|
          format.json {
            render json: {
            }
          }
          end
        end

        # Move down /products/up?id=1
        def move_down
          @product.move_down

          respond_to do |format|
          format.json {
            render json: {
            }
          }
          end
        end
        
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_product
            @product = Product.find(params[:id])
          end
    
          # Only allow a trusted parameter "white list" through.
          def product_params
            params.fetch(:product, {}).permit(:code, :name, :price, :is_sale, :sale_price, :sale_precent, :is_new, :is_bestseller,
                                              :product_category_id, :product_brand_id, :product_material_id, :show_price, :is_eol, :description, :meta_description, :meta_keywords,
                                              :product_images_attributes => [ :id, :image_url, :image_url_cache, :product_id, :_destroy ])
          end
      end
    end
  end
end
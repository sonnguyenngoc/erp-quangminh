module Erp
  module Quangminh
    module Backend
      class ProductBrandsController < Erp::Backend::BackendController
        before_action :set_product_brand, only: [:move_up, :move_down, :show, :edit, :update, :destroy]
    
        # GET /product_brands
        def list
          @product_brands = ProductBrand.search(params).paginate(:page => params[:page], :per_page => 20)
          
          render layout: nil
        end
        
        # GET /product_brands/new
        def new
          @product_brand = ProductBrand.new
          
          if request.xhr?
            render '_form', layout: nil, locals: {product_brand: @product_brand}
          end
        end
    
        # GET /product_brands/1/edit
        def edit
        end
        
        # POST /product_brands
        def create
          @product_brand = ProductBrand.new(product_brand_params)
          @product_brand.creator = current_user
          
          if @product_brand.save
            if request.xhr?
              render json: {
                status: 'success',
                text: @product_brand.name,
                value: @product_brand.id
              }
            else
              redirect_to erp_quangminh.edit_backend_product_brand_path(@product_brand), notice: t('.success')
            end
          else
            if params.to_unsafe_hash['format'] == 'json'
              render '_form', layout: nil, locals: {product_brand: @product_brand}
            else
              render :new
            end            
          end
        end
    
        # PATCH/PUT /product_brands/1
        def update
          if @product_brand.update(product_brand_params)
            if request.xhr?
              render json: {
                status: 'success',
                text: @product_brand.name,
                value: @product_brand.id
              }
            else
              redirect_to erp_quangminh.edit_backend_product_brand_path(@product_brand), notice: t('.success')
            end
          else
            render :edit
          end
        end
    
        # DELETE /product_brands/1
        def destroy
          @product_brand.destroy
          
          respond_to do |format|
            format.html { redirect_to erp_quangminh.backend_product_brands_path, notice: t('.success') }
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
              render json: ProductBrand.dataselect(params[:keyword])
            }
          end
        end
        
        # Move up /product_brands/up?id=1
        def move_up
          @product_brand.move_up

          respond_to do |format|
          format.json {
            render json: {
            }
          }
          end
        end

        # Move down /product_brands/up?id=1
        def move_down
          @product_brand.move_down

          respond_to do |format|
          format.json {
            render json: {
            }
          }
          end
        end
        
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_product_brand
            @product_brand = ProductBrand.find(params[:id])
          end
    
          # Only allow a trusted parameter "white list" through.
          def product_brand_params
            params.fetch(:product_brand, {}).permit(:image_url, :name, :description, :meta_description, :meta_keywords)
          end
      end
    end
  end
end
module Erp
  module Quangminh
    module Backend
      class ProductMaterialsController < Erp::Backend::BackendController
        before_action :set_product_material, only: [:move_up, :move_down, :show, :edit, :update, :destroy]
    
        # GET /product_materials
        def list
          @product_materials = ProductMaterial.search(params).paginate(:page => params[:page], :per_page => 20)
          
          render layout: nil
        end
        
        # GET /product_materials/new
        def new
          @product_material = ProductMaterial.new
          
          if request.xhr?
            render '_form', layout: nil, locals: {product_material: @product_material}
          end
        end
    
        # GET /product_materials/1/edit
        def edit
        end
        
        # POST /product_materials
        def create
          @product_material = ProductMaterial.new(product_material_params)
          @product_material.creator = current_user
          
          if @product_material.save
            if request.xhr?
              render json: {
                status: 'success',
                text: @product_material.name,
                value: @product_material.id
              }
            else
              redirect_to erp_quangminh.edit_backend_product_material_path(@product_material), notice: t('.success')
            end
          else
            if params.to_unsafe_hash['format'] == 'json'
              render '_form', layout: nil, locals: {product_material: @product_material}
            else
              render :new
            end            
          end
        end
    
        # PATCH/PUT /product_materials/1
        def update
          if @product_material.update(product_material_params)
            if request.xhr?
              render json: {
                status: 'success',
                text: @product_material.name,
                value: @product_material.id
              }
            else
              redirect_to erp_quangminh.edit_backend_product_material_path(@product_material), notice: t('.success')
            end
          else
            render :edit
          end
        end
    
        # DELETE /product_materials/1
        def destroy
          @product_material.destroy
          
          respond_to do |format|
            format.html { redirect_to erp_quangminh.backend_product_materials_path, notice: t('.success') }
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
              render json: ProductMaterial.dataselect(params[:keyword])
            }
          end
        end        
        
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_product_material
            @product_material = ProductMaterial.find(params[:id])
          end
    
          # Only allow a trusted parameter "white list" through.
          def product_material_params
            params.fetch(:product_material, {}).permit(:name, :description, :meta_description)
          end
      end
    end
  end
end
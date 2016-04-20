class LineItemComparesController < ApplicationController
  before_action :set_line_item_compare, only: [:show, :edit, :update, :destroy]

  # GET /line_item_compares
  # GET /line_item_compares.json
  def index
    @line_item_compares = LineItemCompare.all
  end

  # GET /line_item_compares/1
  # GET /line_item_compares/1.json
  def show
  end

  # GET /line_item_compares/new
  def new
    @line_item_compare = LineItemCompare.new
  end

  # GET /line_item_compares/1/edit
  def edit
  end

  # POST /line_item_compares
  # POST /line_item_compares.json
  def create
    product = Product.find(params[:product_id])
    @line_item_compare = @compare.line_item_compares.build(product: product)
    
    respond_to do |format|
      if @line_item_compare.save
        format.html { redirect_to controller: "product", action: "product", product_id: product.id }
        format.json { render :show, status: :created, location: @line_item_compare }
      else
        format.html { render :new }
        format.json { render json: @line_item_compare.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_item_compares/1
  # PATCH/PUT /line_item_compares/1.json
  def update
    respond_to do |format|
      if @line_item_compare.update(line_item_compare_params)
        format.html { redirect_to @line_item_compare, notice: 'Line item compare was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_item_compare }
      else
        format.html { render :edit }
        format.json { render json: @line_item_compare.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_item_compares/1
  # DELETE /line_item_compares/1.json
  def destroy
    @line_item_compare.destroy
    respond_to do |format|
      format.html { redirect_to controller: "product", action: "comparison" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item_compare
      @line_item_compare = LineItemCompare.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_compare_params
      params.require(:line_item_compare).permit(:product_id, :compare_id)
    end
end

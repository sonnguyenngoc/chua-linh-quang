class ProductController < ApplicationController
    def category
        @title_head = "Trang chuyên mục"
        @category = Category.find(params[:category_id])
        @products = @category.get_products_for_categories(params).paginate(:page => params[:page], :per_page => params[:number])
        @areas = Area.get_all_areas
        @manufacturers = Manufacturer.get_all_manufacturers
    end
    
    def product
        @title_head = "Trang sản phẩm"
        @product = Product.find(params[:product_id])
        @comment = Comment.new
        @question = Question.new
        #@line_items = LineItem.all
    end
    
    def quick_view
        @product = Product.find(params[:product_id])
        render :layout => false
    end
    
    def add_cart_success
        render :layout => false
    end
    
    def add_wishlist_success
        render :layout => false
    end
    
    def add_compare_success
        render :layout => false
    end
    
    def comparison
        @title_head = "So sánh sản phẩm"
        @compare.remove_item(params[:line_item_compare_id]) if params[:do] == "remove_item"
    end
    
    def search
        @title_head = "Kết quả tìm kiếm"
        @products = Product.search(params).paginate(:page => params[:page], :per_page => params[:number])
    end
    
    def testimonial
        @title_head = "Ý kiến khách hàng"
        @testimonials = Testimonial.get_all_testimonials
    end
    
    def testimonialform
        @title_head = "Gửi ý kiến khách hàng"
        @testimonial = Testimonial.new
    end
    
    def view_all_product_by_status
        if params[:st] == "deal"
            @title_head = "Hàng khuyến mãi"
        elsif params[:st] == "prominent"
            @title_head = "Sản phẩm nổi bật"
        elsif params[:st] == "bestseller"
            @title_head = "Sản phẩm bán chạy"
        elsif params[:st] == "new"
            @title_head = "Sản phẩm mới"
        elsif params[:st] == "imported"
            @title_head = "Hàng nhập khẩu"
        end
        @view_all_products = Product.get_all_product_by_status(params[:st]).paginate(:page => params[:page], :per_page => 15)
    end
    
    def add_cart_buy_now
    quantity = params[:quantity]
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id, quantity)
    @line_item.save

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to controller: "checkout", action: "checkout", product_id: product.id }
      end
    end
    end
end

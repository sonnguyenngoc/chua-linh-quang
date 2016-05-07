class BranchController < ApplicationController
    def list
        @title_head = "Danh sách chi nhánh"
        @branchs = Company.get_branch.paginate(:page => params[:page], :per_page => 15)
    end
end

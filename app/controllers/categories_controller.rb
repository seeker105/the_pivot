class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @content_header = "#{@category.name}"
    @items = @category.items
  end
end

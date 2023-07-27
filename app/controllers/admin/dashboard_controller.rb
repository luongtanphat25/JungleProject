class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['USERNAME'], password: ENV['PASSWORD']

  def show
    @products_count = Product.all.length
    @categories_count = Category.all.length
  end
end

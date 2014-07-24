class StoreController < ApplicationController
  def index
  	@products = Product.order(:title)

  	if session[:counter].nil?
  		session[:counter] = 0
  	end

  	session[:counter] = session[:counter] + 1
  	@counter = session[:counter]
  	@cart = current_cart
  end
end

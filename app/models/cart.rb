class Cart < ActiveRecord::Base
	has_many :line_items, dependent: :destroy

	def add_product(product_id)
		current_item = line_items.find_by_product_id(product_id)
		if current_item
			current_item.quantity = current_item.quantity + 1
		else
			current_item = LineItem.new(:product_id => product_id)
			current_item.price = current_item.product.price
			line_items << current_item
		end
		current_item
	end

	def reduce_product(line_item_id)
		current_item = line_items.find_by_id(line_item_id)
		current_item.quantity -= 1

		if current_item.quantity <= 0
			current_item.destroy
			current_item = nil
		else
			current_item.save
		end

		current_item
	end

	def total_price
		line_items.to_a.sum {|item| item.total_price}
	end
end

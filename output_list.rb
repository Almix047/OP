# frozen_string_literal: true

# Configuration of the output view
class OutputList
  HEADER = %w[
    Name Diagonal Screen CPU RAM Storage Video System Color Price Link
    Offers Discont Offers_Link
    Second_Hand_Price Second_Hand_Link
    Reviews Rated Reviews_link
    Discussion Discussion_link
  ].freeze

  attr_reader :products

  def initialize(products)
    @products = products
    @rows = []
  end

  def call
    prepare_list_data
  end

  private

  def prepare_list_data
    products.flatten.each_with_index do |product, index|
      row = [
        product.name, split_description(product.description), product.price, product.link,
        product.offers, product.discont, product.offers_link,
        product.second_hand_price, product.second_hand_link,
        product.reviews, product.rated, product.reviews_link,
        product.discussion, product.discussion_link
      ].flatten
      @rows.push(row)
    end
    @rows.unshift(HEADER)
  end

  def split_description(text)
    text.split(',')
  end
end

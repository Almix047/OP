# frozen_string_literal: true

# Configuration of the output view
class OutputList
  HEADER = %w[
    Name Diagonal Screen CPU RAM Storage Video System Color Price Discont
    Reviews Discussion Rated Second_Hand_Price Link Offers
    Second_Hand_Link Reviews_link Discussion_link Offers_Link
  ].freeze

  # Name Diagonal Screen CPU RAM Storage Video System Price Discont
  # Reviews Discussion Rated Second_Hand_Price Color Link Offers

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
        product.name, split_description(product.description), product.price, product.discont,
        product.reviews, product.discussion, product.rated, product.second_hand_price, product.link, product.offers,
        product.second_hand_link, product.reviews_link, product.discussion_link, product.offers_link
      ].flatten
      @rows.push(row)
    end
    @rows.unshift(HEADER)
  end

  def split_description(text)
    text.split(',')
  end
end

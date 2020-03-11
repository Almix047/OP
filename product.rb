# frozen_string_literal: true

# Collecting info about product
class Product
  attr_reader :product

  def initialize(product)
    @product = product
  end

  def name
    product.children[3].children[1].children[1].children[1].text
  end

  def description
    product.children[3].children[5].children[1].text.gsub(/[\n]/, '').gsub(/[\"]/, ',')
  end

  def link
    product.children[3].children[1].children[1].attributes['href'].text
  end

  def price
    if product.children[1].children[1].children[13].children[3].children[1].nil?
      product.children[1].children[1].children[13].children[6].children[1].children[3].children[1].text.gsub(',', '.').to_f
    else
      product.children[1].children[1].children[13].children[3].children[1].children[1].text.gsub(',', '.').to_f
    end
  end

  def offers
    product.children[1].children[1].children[13].children[10].children[1].children.text.to_i
  end

  def discont
    if product.children[1].children[1].children[13].children[3].children[1].nil?
      product.children[1].children[1].children[13].children[6].children[1].children[1].children[1].text.to_i
    else
      0
    end
  end

  def offers_link
    product.children[1].children[1].children[13].children[10].children[1].values[3]
  end

  def second_hand_price
    if product.children[1].children[1].children[19].children[1].nil?
      'no item'
    else
      product.children[1].children[1].children[19].children[1].children[1].children[1].text
    end
  end

  def second_hand_link
    if product.children[1].children[1].children[19].children[1].nil?
      'no item'
    else
      product.children[1].children[1].children[19].children[1].children[1].attributes['href'].value
    end
  end

  def reviews
    if product.children[3].children[7].children[1].children[3].children[3].nil?
     0
    else
      product.children[3].children[7].children[1].children[3].children[3].children[1].text.to_i
    end
  end

  def rated
    if product.children[3].children[7].children[1].children[3].children[1].nil?
      'not rated yet'
    else
      product.children[3].children[7].children[1].children[3].children[1].attributes['class'].value.gsub(/['rating rating_']/, '').to_f/10
    end
  end

  def reviews_link
    product.children[3].children[7].children[1].children[3].values.last
  end

  def discussion
    product.children[3].children[7].children[3].children[12].text.to_i
  end

  def discussion_link
    if product.children[3].children[7].children[3].children[3].attributes['href'].nil?
      "discussion didn't start"
    else
      product.children[3].children[7].children[3].children[3].attributes['href'].value
    end
  end
end

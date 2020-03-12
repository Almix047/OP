# frozen_string_literal: true

require_relative 'output_list.rb'
require_relative 'page_parser.rb'
require_relative 'product.rb'
require_relative 'page.rb'
require 'csv'

# Recording scraped Information
class RecordToFile
  def self.save_as_csv_file
    current_page = PageParser.new(URL)
    products_from_current_page = Page.links_on_page(current_page)
    pages_links_arr = Page.products_count(current_page)
    pages_products = pages_links_arr.map { |page| Page.links_on_page(PageParser.new(page)) }.unshift(products_from_current_page)
    products = pages_products.map { |page| page.map { |product| Product.new(product) } }
    rows = OutputList.new(products).call

    # Return if no items to parse are found.
    # 1 because the first row is the HEADER.
    return if rows.length == 1

    CSV.open('result.csv', 'wb') do |csv|
      rows.each { |row| csv << row }
    end
  end
end

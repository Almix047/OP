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
    num_products = Page.products_count(current_page)
    products_on_page = Page.links_on_page(current_page)
    products = products_on_page.map { |product| Product.new(product) }
    rows = OutputList.new(products).call

    # Return if no items to parse are found.
    # 1 because the first row is the HEADER.
    return if rows.length == 1

    CSV.open('result.csv', 'wb') do |csv|
      rows.each { |row| csv << row }
    end
  end
end

# frozen_string_literal: true

# Collecting info about page product
class Page
  def self.links_on_page(page)
    page.fetch_page.xpath("//div[contains(@class, 'schema-product__part schema-product__part_2')]")
    # path = "//*[@class='nombre-producto-list prod-name-pack']//a/@href"
    # parser.fetch_page.xpath(path).map { |link| PetProduct.new(link.text) }
  end

  def self.products_count(page)
    path = "//span[contains(@class, 'schema-filter-button__sub schema-filter-button__sub_main')]"
    text = page.fetch_page.xpath(path).text
    (text.gsub(/[\D]/, '').to_f / 30).ceil - 1
  end
end

require 'open-uri'
require 'nokogiri'

def fetch_products(url)
	sleep 1
	html = url.open.read
	doc = Nokogiri::HTML.parse(html)
	product_elems = doc.css("div.card")
	return nil if product_elems.empty?
	products = product_elems.map do |product|
			name 	= product.at_css('div.card-header').text
			desc 	= product.at_css('div.card-body').text
			price = product.at_css('div.card-footer').text.delete("^0-9")
			{name: name, desc: desc, price: price}
	end
end

url = URI("https://scr-labo.com/sample/chap2.php")
all_products = []
loop do
	p url
	products = fetch_products(url)
	p products
	break if products.nil?
	all_products << products
	url += "?p" if url.query.nil?
	query_params = URI.decode_www_form(url.query).to_h
	query_params["p"] = query_params["p"].to_i + 1
	url.query = URI.encode_www_form(query_params)
end

p all_products.flatten

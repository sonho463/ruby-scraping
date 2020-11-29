require 'open-uri'
require 'nokogiri'

def fetch_html(url)
	sleep 1
	html = url.open.read
end

def fetch_products_num(url)
	url = fetch_html(url)
	doc = Nokogiri::HTML.parse(url)
	doc.at_css('p.products-num').text.delete("^0-9").to_i
end

def fetch_products(url)
	html = fetch_html(url)
	doc = Nokogiri::HTML.parse(html)
	product_elems = doc.css("div.card")
	products = product_elems.map do |product|
			name 	= product.at_css('div.card-header').text
			desc 	= product.at_css('div.card-body').text
			price = product.at_css('div.card-footer').text.delete("^0-9")
			{name: name, desc: desc, price: price}
	end
end

url = URI("https://scr-labo.com/sample/chap2.php")
products_num = fetch_products_num(url)
# 全商品件数を１ページの商品件数で割るとループに必要な回数が求められる
loop_num = products_num / 30 + 1
all_products = []
# 指定回数だけ実行
loop_num.times do
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

p all_products.flatten.size

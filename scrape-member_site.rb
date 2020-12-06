# 今までと同じやり方でのhttpリクエスト

# require 'open-uri'

# url="https://scr-labo.com/sample/chap3-main.php"
# sleep 1
# html = open(url).read

# p html

# cURL形式をrubyプログラム形式に変換してリクエスト
# https://jhawthorn.github.io/curl-to-ruby/

require 'net/http'
require 'uri'

uri = URI.parse("https://scr-labo.com/sample/chap3-main.php")
request = Net::HTTP::Get.new(uri)
request["Authority"] = "scr-labo.com"
request["Cache-Control"] = "no-cache"
request["Upgrade-Insecure-Requests"] = "1"
request["User-Agent"] = "Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.198 Mobile Safari/537.36"
request["Accept"] = "image/avif,image/webp,image/apng,image/*,*/*;q=0.8"
request["Sec-Fetch-Site"] = "same-origin"
request["Sec-Fetch-Mode"] = "no-cors"
request["Sec-Fetch-User"] = "?1"
request["Sec-Fetch-Dest"] = "image"
request["Referer"] = "https://scr-labo.com/sample/chap3-main.php"
request["Accept-Language"] = "ja,en-US;q=0.9,en;q=0.8"
request["Cookie"] = "_ga=GA1.2.1816136822.1604713314; __gads=ID=fac0b5dc66870ff3-227b8ab291c400b3:T=1604713314:RT=1604713314:S=ALNI_Ma2kMoYeSjjiO4W-fWSgvrIqOcegA; _gid=GA1.2.1506442076.1607152411; PHPSESSID=4b751deb3eacd40b5f06966296f147f7"
request["Pragma"] = "no-cache"

req_options = {
  use_ssl: uri.scheme == "https",
}

response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
  http.request(request)
end

puts response.code
p response.code

puts response.body
p response.body

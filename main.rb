require 'net/http'
require 'uri'

url = URI.parse('https://scr-labo.com/')
sleep 1
http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
res = http.get('/sample/chap1.html')
puts res.body


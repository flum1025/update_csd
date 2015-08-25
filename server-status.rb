# coding: utf-8
require 'net/http'
require 'uri'
require 'json'

URL = 'http://csd.hoge.com/servers/update'
uri = URI.parse(URL)
https = Net::HTTP.new(uri.host, uri.port)
req = Net::HTTP::Post.new(uri.request_uri)
req["Content-Type"] = "application/json"
req.body = {
  :NAME=>'LINUX',
  :CPU=>if `uptime | awk '{print $12}'`.chomp.size.zero?
    if `uptime | awk '{print $11}'`.chomp.size.zero?
      `uptime | awk '{print $10}'`.chomp
    else
      `uptime | awk '{print $11}'`
    end
  else
    `uptime | awk '{print $12}'`.chomp
  end,
  :MEM_USED=>`free | head -n 2 | tail -n 1 | awk '{print $3}'`.chomp,
  :MEM_FREE=>`vmstat | tail -n 1 | awk '{print $4}'`.chomp,
  :MEM_SWAP=>`vmstat | tail -n 1 | awk '{print $3}'`.chomp,
  :Operating_time=>`cat /proc/uptime | awk '{print $1}'`.chomp,
  :Process_number=>`ps alx | wc -l`.chomp,
  :Zombie_process=>`top | head -n 2 | tail -n 1 | awk '{print $10}'`.chomp,
  :High_CPU_Process=>`top | grep -v top | head -n 11 | tail -n 5 | awk '{print $10" "$13}'`.chomp,
  :High_MEM_Process=>`ps alx --sort -rss | head -n 6 | tail -n 5 | awk '{print $8" "$13" "$14}'`.chomp,
  :TEMP=>`cat /sys/class/thermal/thermal_zone0/temp`.chomp,
}.to_json
res = https.request(req)
puts res.body
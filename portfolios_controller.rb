class PortfoliosController < ApplicationController
  
  require 'nokogiri'
  require 'open-uri'

  url = 'https://apis.tdameritrade.com/apps/100/BalancesAndPositions?source=#{source_id}&'
  ameritrade = open(url)
  doc = Nokogiri::XML(ameritrade)

  @links = doc.xpath('//positions/stocks').map do |i|
  	{'symbol' => i.xpath('symbol'), 'current-value' => i.xpath('current-value')}
  end

# optional query parameters, other than source
# accountid
# type
# suppressquotes
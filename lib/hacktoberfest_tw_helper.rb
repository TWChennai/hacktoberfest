module HacktoberfestTwHelper
  def start_date(item=nil)
    item ||= @item
    Time.parse item[:start]
  end

  def all_editions
    @items.select do |event|
      !!event[:edition]
    end.sort_by do |event|
      -event[:edition]
    end
  end

  def archives
    all_editions[1..all_editions.length]
  end

  def groupYearMonths
    return @items.select {|event| !event[:start].nil?}.sort_by { |i| i[:edition]}.reverse.group_by {|i| [i[:start].to_date.year, i[:start].to_date.strftime("%b %d")]}
  end

  def getEvents
    events=[]
    groupYearMonths.each do |event|
      events.push({event[0].first=>event[0].last})
    end
    return Hash[events.group_by {|i| i.keys}.map{|k,v| [k, v.map{ |k1|  k1.map{|k2,v2| v2 }}.flatten] }]
  end

  def latest
    @@first ||= all_editions.first
  end

  def json_of_event(item)
    {'@context' => 'http://schema.org', '@type' => 'EducationEvent', 'name' => "Hacktoberfest TW Chennai - #{Time.parse(item[:start]).strftime("%b %Y")}",
     'startDate' => Time.parse(item[:start]).iso8601, 'url' => "http://twchennai.github.io/hacktoberfest#{item.path}",
     'location' => {'@type' => 'Place', 'name' => 'ThoughtWorks', 'address' => {
        '@type' => 'PostalAddress', 'addressLocality' => 'Chennai', 'addressRegion' => 'Tamil Nadu', 'postalCode' => '600113', 'streetAddress' => 'Ascendas'
    }}}.to_json
  end
end

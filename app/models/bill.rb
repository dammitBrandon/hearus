class Bill < ActiveRecord::Base


  def self.search_query(params)
    url = keyword_string(params)
    uri_object = escape_string(url)
    results = make_get_request(uri_object)
    display_bills(results)
  end

  def self.keyword_string(query_string)
    base = "http://congress.api.sunlightfoundation.com/bills/search?query="
    base += query_string + "&history.enacted=false&"
    base + "apikey=" + Sunlight::Base.api_key
  end

  def self.escape_string(url)
    URI.escape(url)
  end


  def self.make_get_request(uri_object)
    HTTParty::get(uri_object)
  end

  def self.bill_number(bill)
    bill["bill_id"]

  end

  def self.display_bills(results)
    results = results["results"]
    results.each do |bill|
      puts
      puts
      p bill
      # puts "short title"
      # puts  bill["short_title"]
      # puts "committee ids"
      # puts bill["committee_ids"]
      # puts bill["urls"]["opencongress"]
      # puts "pdf"
      # puts bill["last_version"]["urls"]["pdf"]
      # puts "search"
      # puts bill["search"]
      # puts "search highlight"
      # puts bill["search"]["highlight"]
      # puts "search highlight text"
      # puts bill["search"]["highlight"]["text"]
    end
  end
end

class Bill

  def self.search_query(params)
    url = self.keyword_string(params)
    uri_object = self.escape_string(url)
    results = self.make_get_request(uri_object)
    self.display_bills(results)
  end

  def self.view_bill(bill_id)
    url = self.bill_id_string(bill_id)
    uri_object = self.escape_string(url)
    result = self.make_get_request(uri_object)
    self.display_bill(result)
  end

  def self.bill_id_string(bill_id)
    base = "http://congress.api.sunlightfoundation.com/bills?bill_id="
    base += bill_id + "&"
    base + self.api_string
  end

  def self.keyword_string(query_string)
    base = "http://congress.api.sunlightfoundation.com/bills/search?query="
    base += query_string + "&"
    base + self.api_string
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
      #Brandon's Work
    end
  end

  def self.display_bill(response)
    response["results"].first
  end

  def self.api_string
    "apikey=" + Sunlight::Base.api_key
  end
end



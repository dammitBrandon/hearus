class Bill

  def self.search_query(keyword)
    @keyword = keyword
    uri_object =  URI.escape(self.keyword_string)
    @results = HTTParty::get(uri_object)
    self.display_bills_for_keyword
  end

  def self.view_bill(bill_id)
    @bill_id = bill_id
    uri_object = URI.escape(self.bill_url)
    @response = HTTParty::get(uri_object)
    self.display_unique_bill
  end

private
  def self.bill_url
    base = "http://congress.api.sunlightfoundation.com/bills?bill_id="
    base += @bill_id + "&"
    base + self.api_string
  end

  def self.keyword_string
    base = "http://congress.api.sunlightfoundation.com/bills/search?query="
    base += @keyword + "&history.enacted=false&"
    base + self.api_string
  end

  def self.display_bills_for_keyword
    results = @results["results"]
    results.each do |bill|
      puts bill#Brandon's Work
    end
  end

  def self.display_unique_bill
    @response["results"].first
  end

  def self.api_string
    "apikey=" + Sunlight::Base.api_key
  end
end



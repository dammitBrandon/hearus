module SunlightHelper
  def search_query(keyword)
    @keyword = keyword
    uri_object =  URI.escape(keyword_string)
    @results = HTTParty::get(uri_object)
    display_bills_for_keyword
  end

  def view_bill(bill_id)
    @bill_id = bill_id
    uri_object = URI.escape(bill_url)
    @response = HTTParty::get(uri_object)
    display_unique_bill
  end

private
  def bill_url
    base = "http://congress.api.sunlightfoundation.com/bills?bill_id="
    base += @bill_id + "&"
    base + api_string
  end

  def keyword_string
    base = "http://congress.api.sunlightfoundation.com/bills/search?query="
    base += @keyword + "&history.enacted=false&"
    base + api_string
  end

  def display_bills_for_keyword
    results = @results["results"]
    results.each do |bill|
      puts bill#Brandon's Work
    end
  end

  def display_unique_bill
    @response["results"].first
  end

  def api_string
    "apikey=" + Sunlight::Base.api_key
  end
end

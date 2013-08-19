module ApplicationHelper
  require "sunlight"
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def current_user?
    false unless current_user
  end

  def current_district
    @current_district||= District.find_by_id(session[:district_id])
  end

  def current_district?
    true if current_district
  end

  def search_query(params)
    url = keyword_string(params)
    uri_object = escape_string(url)
    results = make_get_request(uri_object)
    display_bills(results)
  end

  def keyword_string(query_string)
    base = "http://congress.api.sunlightfoundation.com/bills/search?query="
    base += query_string + "&"
    base + "apikey=" + Sunlight::Base.api_key
  end

  def escape_string(url)
    URI.escape(url)
  end


  def make_get_request(uri_object)
    HTTParty::get(uri_object)
  end

  def bill_number(bill)
    bill["bill_id"]

  end

  def display_bills(results)
    results = results["results"]
    results.each do |bill|
      p bill
      puts "short title"
      puts  bill["short_title"]
      puts "committee ids"
      puts bill["committee_ids"]
      puts bill["urls"]["opencongress"]
      puts "pdf"
      puts bill["last_version"]["urls"]["pdf"]
      # puts "search"
      # puts bill["search"]
      # puts "search highlight"
      # puts bill["search"]["highlight"]
      # puts "search highlight text"
      # puts bill["search"]["highlight"]["text"]
    end; 0
  end

end



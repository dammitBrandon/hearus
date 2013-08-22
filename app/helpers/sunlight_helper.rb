module SunlightHelper
  def search_query(keyword)
    @keyword = keyword
    uri_object =  URI.escape(summary_bills_search)
    @results = HTTParty::get(uri_object)
    display_bills_for_search
  end

  def view_bill(bill_id)
    @bill_id = bill_id
    uri_object = URI.escape(summary_bill_select)
    @response = HTTParty::get(uri_object)
    display_bill_for_select
  end

  private

  def general_bill_select
    base = "http://congress.api.sunlightfoundation.com/bills?bill_id="
    base += @bill_id + "&"
    base + api_string
  end

  def summary_bill_select
    base = "http://congress.api.sunlightfoundation.com/bills?bill_id="
    base += @bill_id + "&" + "&fields=bill_id,bill_type,chamber,popular_title,short_title,official_title,urls,history,last_action,sponsor_id,commitee_ids,related_bill_ids,nicknames,keywords,summary,summary_short,last_version&"
    base + api_string
  end

  def general_bills_search
    base = "http://congress.api.sunlightfoundation.com/bills/search?query="
    base += @keyword + "&history.enacted=false&"
    base + api_string
  end

  def summary_bills_search
    base ="http://congress.api.sunlightfoundation.com/bills/search?query="
    base += @keyword + "&fields=bill_id,bill_type,chamber,popular_title,short_title,official_title,urls,history,last_action,sponsor_id,commitee_ids,related_bill_ids,nicknames,keywords,summary,summary_short&"
    base + api_string
  end

  def display_bills_for_search
    @results["results"]
  end

  def display_bill_for_select
    puts @response["results"].first
    @response["results"].first
  end

  def api_string
    "apikey=" + Sunlight::Base.api_key
  end
end



module BillHelper

  include SunlightHelper

  def bill_link(bill_id)
    view_bill(bill_id)["short_title"]
  end
end

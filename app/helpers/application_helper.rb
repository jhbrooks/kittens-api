module ApplicationHelper
  def full_title(page_title = "")
    base_title = "Kittens API"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  def pretty_decimal(decimal)
    return decimal.to_i if (decimal - decimal.truncate == 0)
    decimal
  end
end

module TodosHelper
  def filter_path(filter)
    root_path(filter: filter)
  end

  def filter_active?(name)
    @filter.to_s == name.to_s
  end

  def priority_tone(priority)
    case priority
    when Todo::PRIORITIES[:high] then "high"
    when Todo::PRIORITIES[:low] then "low"
    else "medium"
    end
  end

  def today_label
    Time.zone.now.strftime("%A · %d %b")
  end
end

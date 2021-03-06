module Listable
  def format_description(description, type)
    "#{description} (#{type})".ljust(35)
  end
  def format_date(options={})
  	if options[:due]
  	  dates = Chronic::parse(options[:due]).to_s
  	end

    dates = options[:start_date].strftime("%D") if options[:start_date]
    dates << " -- " + options[:end_date].strftime("%D") if options[:end_date]
    dates = "N/A" if !dates
    return dates
  end
  def format_priority(options={})
  	priority = options[:priority]
    value = " ⇧".colorize(:red) if priority == "high"
    value = " ⇨".colorize(:blue) if priority == "medium"
    value = " ⇩".colorize(:green) if priority == "low"
    value = "" if ! priority
    return value
  end
end

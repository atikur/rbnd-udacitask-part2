class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title]
    @items = []
  end
  def add(type, description, options={})
    options[:type] = type
    type = type.downcase
    @items.push TodoItem.new(description, options) if type == "todo"
    @items.push EventItem.new(description, options) if type == "event"
    @items.push LinkItem.new(description, options) if type == "link"

    if !(type == "todo" || type == "event" || type == "link")
      raise UdaciListErrors::InvalidItemType, "Invalid item type: #{type}"
    end

    priority = options[:priority]
    if priority && !(priority == "high" || priority == "medium" || priority == "low")
      raise UdaciListErrors::InvalidPriorityValue, "Invalid priority value #{priority}"
    end
  end
  def delete(index)
    if index > @items.count
      raise UdaciListErrors::IndexExceedsListSize, "Item at index #{index} doesn't exist."
    end
    @items.delete_at(index - 1)
  end
  def all
    rows = []

    @title = "Untitled List" if !@title
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      rows << ["#{position + 1}", item.details]
    end
    table = Terminal::Table.new :rows => rows
    puts table
  end
end

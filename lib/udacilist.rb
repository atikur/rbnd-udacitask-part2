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
    @items.push EmailItem.new(description, options) if type == "email"

    if !(type == "todo" || type == "event" || type == "link" || type == "email")
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
  def clear
    @items = []
  end
  def filter(item_type)
    title = "#{item_type.capitalize} Items"
    print title, @items.select {|item| item.type == item_type}
  end
  def all
    @title = "Untitled List" if !@title
    print title, @items
  end
  def print(title, items)
    rows = []

    puts "-" * title.length
    puts title
    puts "-" * @title.length

    if items.count == 0
      puts "No items found."
    else
      items.each_with_index do |item, position|
        rows << ["#{position + 1}", item.details]
      end
      table = Terminal::Table.new :rows => rows
      puts table
    end
  end
end

class TodoItem
  include Listable
  attr_reader :description, :due, :priority, :type

  def initialize(description, options={})
    @description = description
    @due = options[:due]
    @priority = options[:priority]
    @type = options[:type]
  end
  def details
    format_description(@description, @type) + "due: " +
    format_date({due: @due}) +
    format_priority({priority: @priority})
  end
end
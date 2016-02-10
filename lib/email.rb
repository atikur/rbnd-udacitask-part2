class EmailItem
  include Listable
  attr_reader :description, :contact_name, :type

  def initialize(email, options={})
    @description = email
    @contact_name = options[:contact_name]
    @type = options[:type]
  end
  def format_name
    @contact_name ? @contact_name : ""
  end
  def details
    format_description(@description, @type) + "Contact name: " + format_name
  end
end
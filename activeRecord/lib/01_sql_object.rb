require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    # ...
    return @columns if @columns
    @columns = DBConnection.execute2(<<-SQL)
    SELECT
      *
    FROM
      "#{self.table_name}"
    SQL
    @columns = @columns.first.map(&:to_sym)

  end

  def self.finalize!
    self.columns

    @columns.each do |name|
      #debugger
      define_method(name){ self.attributes[name] }
      define_method("#{name}=") { |val| self.attributes[name] = val}

    end
  end

  def self.table_name=(table_name)
    # ...
    @table_name = table_name
  end

  def self.table_name
    # ...

    obj = self.new
    return obj.class.to_s.tableize if @table_name.nil?
    @table_name
  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    #

    self_col = self.class.columns
    params.each do |k, v|
      # raise 'unknown attribute ' unless self_col.include?(k.to_sym)
        puts k
    end
  end

  def attributes
    # ...
    unless @attributes
        return @attributes={}
    end
    @attributes
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end

Mongoid.configure do |config|
  config.master = Mongo::Connection.new.db("godfather")
end

Rolify.use_mongoid

# Mongoid models
class User
  include Mongoid::Document
  include Rolify::Roles
  extend Rolify::Dynamic
  has_and_belongs_to_many :roles
  
  field :login, :type => String
end

class Role
  include Mongoid::Document
  has_and_belongs_to_many :users
  belongs_to :resource, :polymorphic => true
  
  field :name, :type => String
end

class Forum
  include Mongoid::Document
  
  field :name, :type => String
end

class Group
  include Mongoid::Document
  
  field :name, :type => String
end

class Customer
  include Mongoid::Document
  include Rolify::Roles
  extend Rolify::Dynamic
  has_and_belongs_to_many :roles, :class_name => "Privilege"
  
  field :login, :type => String
end

class Privilege
  include Mongoid::Document
  has_and_belongs_to_many :customers
  belongs_to :resource, :polymorphic => true
  
  field :name, :type => String
end
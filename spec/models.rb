require 'active_record'

class Person < ActiveRecord::Base
  field :name, :string, null: false, default: ''
  field :age, :integer
  field :score, :decimal, precision: 10, scale: 10, null: true

  field :external_id, :string, limit: 10
  rename :external_id, :e_id
  field :e_id, :string, limit: 10

  belongs_to :country
  has_many :pictures, as: :imageable
  has_and_belongs_to_many :roles

  index :e_id

  timestamps
end

class Picture < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
end

class Country < ActiveRecord::Base
  field :name, :string
  has_many :pictures, as: :imageable
end

class Role < ActiveRecord::Base
  field :name
  has_and_belongs_to_many :people
end

Person.migrate!
Country.migrate!
Role.migrate!
Picture.migrate!

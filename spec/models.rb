require 'active_record'

class Person < ActiveRecord::Base
  field :name, :string, null: false, default: ''
  field :age, :integer
  field :score, :decimal, precision: 10, scale: 10, null: true
  field :external_id, :string, length: 10

  belongs_to :country
  has_and_belongs_to_many :roles

  index :external_id

  timestamps
end

class Country < ActiveRecord::Base
  field :name, :string
end

class Role < ActiveRecord::Base
  field :name
  has_and_belongs_to_many :people
end

Person.migrate!
Country.migrate!
Role.migrate!

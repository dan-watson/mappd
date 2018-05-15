# README

Mappd is a replacement gem for [mini_record](https://github.com/DAddYE/mini_record). Mini record is great and I have been using it for a number of years. Unfortunately the mini_record report has not been updated in some time. With recent rails upgrades mini_record is not working well.

Mappd is designed to work with ActiveRecord 5.2 >.

It's simple to use.

```ruby
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
```

Hey presto your database has been created with the correct schema.

## Todo

* Renaming a column

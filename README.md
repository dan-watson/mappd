# Mappd

[![Build Status](https://travis-ci.org/dan-watson/mappd.svg?branch=master)](https://travis-ci.org/dan-watson/mappd)

Mappd is a replacement gem for [mini_record](https://github.com/DAddYE/mini_record). Mini record is great and I have been using it for a number of years. Unfortunately the mini_record repo has not been updated in some time. With recent rails upgrades mini_record is not working well.

Mappd is designed to work with ActiveRecord 5.2 >.

It's simple to use.

## Setup

```
  gem install mappd
```

Or add to your `Gemfile`:

```
  gem 'mappd'
```

## Models

```ruby
class Person < ActiveRecord::Base
  field :name, :string, null: false, default: ''
  field :age, :integer
  field :score, :decimal, precision: 10, scale: 10, null: true

  # Rename a field - the old field and rename could be removed after
  # migrate! is called
  field :external_id, :string, length: 10
  rename :external_id, :e_id
  field :e_id, :string, length: 10
  # Delete a field - the old field and drop could be removed after
  # migrate! is called
  drop :name

  # Hooks into belongs_to and creates a country_id column
  # with an index
  belongs_to :country

  has_many :pictures, as: :imageable
  
  # Creates a join table people_roles
  has_and_belongs_to_many :roles

  # Creates an index
  index :e_id

  # Creates created_at and updated_at columns
  timestamps
end

class Picture < ActiveRecord::Base
  # Creates a imageable_id and imageable_type
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
```

Hey presto your database has been created with the correct schema.

## Types & Options - Field

```field :name, :type, options = {}```

The type parameter is normally one of the migrations native types, which is one of the following: 

```:primary_key``` 
```:string```
```:text```
```:integer```
```:bigint```
```:float```
```:decimal```
```:numeric```
```:datetime```
```:time```
```:date```
```:binary```
```:boolean```

You may use a type not in this list as long as it is supported by your database (for example, “polygon” in MySQL), but this will not be database agnostic and should usually be avoided.

Available options are (none of these exists by default):

```:limit``` - Requests a maximum column length. This is the number of characters for a :string column and number of bytes for :text, :binary and :integer columns. This option is ignored by some backends.

```:default``` - The column's default value. Use nil for NULL.

```:null``` - Allows or disallows NULL values in the column.

```:precision``` - Specifies the precision for the :decimal and :numeric columns.

```:scale``` - Specifies the scale for the :decimal and :numeric columns.

```:comment``` - Specifies the comment for the column. This option is ignored by some backends.

## Using Rails?

Create a `mappd.rb` initializer inside `config/initializers` and add the following code to auto migrate rails models on every application restart.

```ruby
  Dir.glob('app/models/**/*.rb').each do |file_path|
    basename = File.basename(file_path, File.extname(file_path))
    clazz = basename.camelize.constantize
    next if clazz.abstract_class
    clazz.migrate! if clazz.ancestors.include?(ActiveRecord::Base)
  end
```

## Donations

Mappd is free to all, but donations are welcome.

Bitcoin: 16HWaWap47gEk641Aim2gN4wp1ZM3eodnz

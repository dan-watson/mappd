require 'byebug'
require File.expand_path('boot.rb', __dir__)
require File.expand_path('spec_helper.rb', __dir__)
require File.expand_path('models.rb', __dir__)

context '#create table' do
  it 'is nil when a table already exists' do
    expect(Person.send(:create_table!)).to be_nil
  end
end

RSpec.describe Person, type: :model do
  it { should have_db_column(:name).of_type(:string) }
  it { should have_db_column(:age).of_type(:integer) }
  it {
    should have_db_column(:score).of_type(:decimal)
                                 .with_options(precision: 10,
                                               scale: 10,
                                               null: true)
  }
  it {
    should have_db_column(:external_id).of_type(:string)
                                       .with_options(length: 10)
  }

  it { should have_db_column(:country_id).of_type(:integer) }
  it { should have_db_index(:country_id) }
  it { should have_db_index(:external_id) }

  context '#change column' do
    before(:all) do
      Person.field(:age, :string)
      Person.migrate!
    end

    it { should have_db_column(:age).of_type(:string) }
  end
end

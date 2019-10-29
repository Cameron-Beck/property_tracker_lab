require('pry-byebug')
require_relative('./models/property_tracker.rb')

Property.delete_all()

property1 = Property.new ({
  'address' => 'Royal Mile',
  'value' => 2000000,
  'number_of_bedrooms' => 2,
  'year_built' => 1990
  })

property2 = Property.new ({
  'address' => 'Granton',
  'value' => 185000,
  'number_of_bedrooms' => 3,
  'year_built' => 2008
  })

property1.save()
property2.save()

binding.pry

nil

require("pg")

class Property

  attr_accessor :address, :value, :number_of_bedrooms, :year_built
  attr_reader :id

  def initialize(options)
    @address = options['address']
    @value = options['value'].to_i
    @number_of_bedrooms = options['number_of_bedrooms'].to_i
    @year_built = options['year_built'].to_i
    @id = options['id'].to_i if options['id']
  end

  def update()
    db = PG.connect( { dbname: 'property', host: 'localhost' } )
    sql = "UPDATE property_trackers
      SET
      (
        address,
        value,
        number_of_bedrooms,
        year_built
      ) =
      (
        $1, $2, $3, $4
      )
      WHERE id = $5"
    values = [@address, @value, @number_of_bedrooms, @year_built, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close
  end

  def save()
    db = PG.connect( { dbname: 'property', host: 'localhost' } )
    sql = "INSERT INTO property_trackers
      (
        address,
        value,
        number_of_bedrooms,
        year_built
      )
      VALUES
      (
      $1,$2,$3,$4
      )
      RETURNING id"
    values = [@address, @value, @number_of_bedrooms, @year_built]
    db.prepare("save", sql)

    @id = db.exec_prepared("save", values)[0]['id'].to_i
    db.close
  end

  def Property.select(id)
    db = PG.connect( { dbname: 'property', host: 'localhost' } )
    sql =  "SELECT * FROM property_trackers
      WHERE id = $1"
    values = [id]
    db.prepare("select", sql)
    result_array = db.exec_prepared("select", values)
    db.close
    property_hash = result_array[0]
    found_property = Property.new(property_hash)
    return found_property
  end

  def delete()
    db = PG.connect( { dbname: 'property', host: 'localhost' } )
    sql =  "DELETE FROM property_trackers
      WHERE id = $1"
    values = [@id]
    db.prepare("delete", sql)
    db.exec_prepared("delete", values)
    db.close
  end

  def Property.delete_all()
    db = PG.connect( { dbname: 'property', host: 'localhost' } )
    sql = "DELETE FROM property_trackers"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close
  end

  def Property.all()
    db = PG.connect( { dbname: 'property', host: 'localhost' } )
    sql = "SELECT * FROM property_trackers"
    db.prepare("all", sql)
    orders = db.exec_prepared("all")
    db.close
    return orders.map { |order_hash| Property.new( order_hash ) }
  end

end

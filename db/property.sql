DROP TABLE IF EXISTS property_trackers;


CREATE TABLE property_trackers(
  id SERIAL4 PRIMARY KEY,
  address VARCHAR(255),
  value INT4,
  number_of_bedrooms INT2,
  year_built INT2
)

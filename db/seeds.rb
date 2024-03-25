# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Employee.create(
  name: "admin",
  email: "admin@gmail.com",
  address: "Admin Address",
  mobile: "9172845587",
  is_manager: false,
  role: "admin",
  password: "123456",
)

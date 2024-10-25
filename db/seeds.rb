# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

main_admin = User.create(
  email: 'admin@user.com',
  name: 'Administrator User',
  phone: '+56 9 1234 5678',
  address: 'Av. Admin 1234',
  description: 'Admin User', 
  password: '123456',
  password_confirmation: '123456',
  admin: true
)

homer = User.create(
  email: 'homer@gmail.com',
  name: 'Homer',
  phone: '+5612345645',
  address: '742 Evergreen Terrace',
  description: 'Hola soy homero', 
  password: '123456',
  password_confirmation: '123456',
  admin: false
)

marge = User.create(
  email: 'marge@gmail.com',
  name: 'Marge',
  phone: '+56 968456183',
  address: '742 Evergreen Terrace',
  description: 'Hola soy marge', 
  password: '123456',
  password_confirmation: '123456',
  admin: false
)

bart = User.create(
  email: 'bart@gmail.com',
  name: 'Bart',
  phone: '+56 9 4321 5678',
  address: '742 Evergreen Terrace',
  description: 'Hola soy bart', 
  password: '123456',
  password_confirmation: '123456',
  admin: false
)
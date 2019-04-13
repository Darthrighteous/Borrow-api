# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = [
  {
    name: 'Nnamdi Azikwe',
    email: 'nnamdi.azikwe@borrow.com',
    phone_no: '+2348094762345',
    income: 50_000,
    expenses: 25_000,
    credit_score: 750
  },
  {
    name: 'Bill gates',
    email: 'bill.gates@borrow.com',
    phone_no: '+2347064733999',
    income: 1_000_000,
    expenses: 200_000,
    credit_score: 700
  },
  {
    name: 'David Mardling',
    email: 'david.mardling@borrow.com',
    phone_no: '+2348063453232',
    income: 500_000,
    expenses: 400_000,
    credit_score: 600
  }
]

User.create(users)

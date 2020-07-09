# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  name: 'first-user',
  email: 'first@gmail.com',
  password: 'password',
  profile: 'デフォルトで作成されている1人目のユーザーです。',
  birth: '1995/01/01',
  profile_image: File.open('./app/assets/images/first-user.jpg',?r),
  sex: '1', # 1:男　2:女　3:その他
  is_valid: true, # true:有効 false:退会済
)

Admin.create!(
  email: 'admin@gmail.com',
  password: '111111'
)
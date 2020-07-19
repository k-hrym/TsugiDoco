# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  [
    {
      name: 'first-user',
      email: 'first@gmail.com',
      password: 'password',
      profile: 'デフォルトで作成されている1人目のユーザーです。',
      birth: '1995/01/01',
      profile_image: File.open('./app/assets/images/first-user.jpg',?r),
      sex: '1', # 1:男　2:女　3:その他
      is_valid: true, # true:有効 false:退会済
    },
    {
      name: 'second-user',
      email: 'second@gmail.com',
      password: 'password',
      profile: 'デフォルトで作成されている2人目のユーザーです。',
      birth: '1995/01/01',
      profile_image: File.open('./app/assets/images/second-user.jpg',?r),
      sex: '1', # 1:男　2:女　3:その他
      is_valid: true, # true:有効 false:退会済
    }
  ]
)

Admin.create!(
  email: 'admin@gmail.com',
  password: '111111'
)


['居酒屋','カフェ','公園','レストラン','公共施設','遊ぶ','体験','サウナ'].each do |name|
  Genre.create!(name: name)
end

Place.create!(
  [
    {
      genre_id: '3',
      name: '代々木公園'
    },
    {
      genre_id: '2',
      name: 'Tsugi Cafe'
    },
    {
      genre_id: '1',
      name: '居酒屋DOC'
    }
  ]
)

User.all.each do |user|
  user.routes.create!(
    title: "#{user.name}の初投稿",
    explanation: "#{user.name}の初投稿として自動生成されています",
    status: true
  )
end

[
  ['1','1',File.open('./app/assets/images/park.jpg',?r)],
  ['1','2',File.open('./app/assets/images/cafe.jpg',?r)],
  ['2','3',File.open('./app/assets/images/izakaya.jpg',?r)]
].each do |user, place, img|
  PlaceImage.create(
    {user_id: user,place_id: place,image: img}
  )
end

Spot.create!(
  [
    {
      route_id: '1',
      place_id: '1',
      order: '1'
    },
    {
      route_id: '1',
      place_id: '2',
      order: '2'
    },
    {
      route_id: '2',
      place_id: '2',
      order: '1'
    },
    {
      route_id: '2',
      place_id: '3',
      order: '2'
    },
    {
      route_id: '2',
      place_id: '1',
      order: '3'
    }
  ]
)
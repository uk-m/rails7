User.create!(name: "Admin User",
             email: "admin@mail.co.jp",
             password: "password",
             password_confirmation: "password",
             admin: true)
Category.create!([
  { name: 'キャリア' },
  { name: 'スキル'}
  ])
User.create!(name: "Admin User",
             email: "admin@mail.co.jp",
             password: "password",
             password_confirmation: "password",
             admin: true)
Category.create!([
  { name: 'IT' },
  { name: '金融'},
  { name: '保険' },
  { name: 'メーカー'},
  { name: '商社' },
  { name: '小売'},
  { name: '外食' },
  { name: 'サービス'},
  { name: '不動産' },
  { name: '建設'},
  { name: 'コンサル' },
  { name: 'マスコミ'},
  { name: '広告' },
  { name: 'ゲーム' },
  { name: 'エンターテイメント'},
  { name: '物流' },
  { name: 'その他'}
  ])
# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 5.times do
#  Councilman.create([{
#    name: Faker::Name.name,
#    nickname: Faker::GameOfThrones.character,
#    political_party: Faker::Name.initials,
#    political_position: 1,
#  }])
# end
User.create([{
              name: 'Teste',
              email: 'teste@teste.com',
              password: '123456'
            }])

Councilman.create([{
                    name: 'Celso Lara da Costa',
                    nickname: 'Celso Costa',
                    political_party: 'PPS',
                    political_position: :situation
                  }])

Councilman.create([{
                    name: 'Danilo Dominico',
                    nickname: 'Danilo',
                    political_party: 'PSD',
                    political_position: :opposition
                  }])

Councilman.create([{
                    name: 'Aldonei Luiz Bonfim',
                    nickname: 'Dognei',
                    political_party: 'PDT',
                    political_position: :situation
                  }])

5.times do
  Meeting.create([{
                   date: Faker::Date.between(30.days.ago, Date.today),
                   start_session: Faker::Time.between(2.days.ago, Date.today, :morning),
                   end_session: Faker::Time.between(2.days.ago, Date.today, :afternoon),
                   note: Faker::Lorem.paragraph(2)
                 }])
end

# 5.times do
#  ProjectKind.create([{
#    kind: Faker::Name.name,
#    description: Faker::Lorem.paragraph(1),
#  }])
# end

ProjectKind.create([{
                     kind: 'Educacional',
                     description: Faker::Lorem.paragraph(1)
                   }])

ProjectKind.create([{
                     kind: 'Saúde',
                     description: Faker::Lorem.paragraph(1)
                   }])

ProjectKind.create([{
                     kind: 'Nome de Rua',
                     description: Faker::Lorem.paragraph(1)
                   }])

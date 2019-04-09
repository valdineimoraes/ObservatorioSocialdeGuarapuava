
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
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

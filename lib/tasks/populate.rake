require './spec/support/file_spec_helper'

namespace :db do
  desc 'Erase and Fill database'
  task populate: :environment do
    [PoliticalMandate,
     Vote,
     Meeting,
     ProjectKind,
     Project,
     Councilman,
     SessionCouncilman].each(&:delete_all)

    User.create_with(name: 'Teste', password: '123456')
        .find_or_create_by!(email: 'teste@teste.com')
    
    User.create_with(name:'Admin', password: '123456')
        .find_or_create_by!(email: 'admin@admin.com' )

    2.times do
      PoliticalMandate.find_or_create_by!(
        description: Faker::Restaurant.unique.name,
        first_period: Faker::Date.between(2.year.ago, 9.months.ago),
        final_period: Faker::Date.between(0.year.ago, 2.months.ago)
      )
    end

    5.times do
      Meeting.find_or_create_by!(
        date: Faker::Date.between_except(1.year.ago, 1.year.from_now, Date.today),
        start_session: Faker::Time.between(2.days.ago, Date.today, :morning),
        end_session: Faker::Time.between(2.days.ago, Date.today, :afternoon),
        note: Faker::Lorem.paragraph(2)
      )
    end

    5.times do
      ProjectKind.find_or_create_by!(
        kind: Faker::Commerce.unique.material,
        description: Faker::Lorem.paragraph(1)
      )
    end

    15.times do
      Councilman.find_or_create_by!(
        name: Faker::Name.unique.name,
        nickname: Faker::Name.unique.last_name,
        office: Faker::Job.field,
        political_party: Faker::Name.initials,
        political_mandate: PoliticalMandate.all.sample
      )
    end

    25.times do
      Project.find_or_create_by!(
        meeting: Meeting.all.sample,
        councilman: Councilman.all.sample,
        name: Faker::Hipster.sentence,
        project_kind: ProjectKind.all.sample,
        description: Faker::Lorem.paragraph(2)
      )
    end
  end
end

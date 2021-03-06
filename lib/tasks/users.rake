namespace :users do
  desc 'Initialize new users'
  task initialize: :environment do
    FortyTwo::Api.instance.get('/v2/users', sort: '-id') do |users_payload|
      continue = true

      users_payload.each do |user_data|
        continue = !FortyTwo::User.exists?(user_data.id)
        UserJob.perform_later(user_data.id)
      end

      continue
    end
  end

  desc 'Update all users'
  task update: :environment do
    FortyTwo::Api.instance.get('/v2/users', sort: '-id') do |users_payload|
      users_payload.each do |user_data|
        UserJob.perform_later(user_data.id)
      end
    end
  end
end

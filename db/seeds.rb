user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email


puts "Creating band members"
band_members = ["Aaron Anderson", "Robbie Connolly", "Brandon Kitterman", "Stuart Maxfield"]
band_members.each do |member|
  User.invite! email: "#{member.split(' ').first}@fictionist.com", name: member, password: '1234567890', role: 1 do |u|
    u.skip_invitation = true
  end
end

puts "Accepting band members invites"
User.all.each do |u|
  u.accept_invitation!
end

puts "Creating band member content"
@image_categories = %w( animals arch nature people tech )
@image_sizes = %w( 500 550 400 450 425 525 475 )

User.where(role: 1).each do |user|
  10.times do
    a = user.uploaded_contents.new
    a.message = Faker::Lorem.sentence
    a.published_at = Time.now
    a.view_permission = ['free', 'points'].sample
    if rand(0..10).odd?
      puts "creating mp3"
      a.asset = File.open("#{Rails.root}/app/assets/music/creep.mp3")
    else
      puts "creating image"
      a.asset = open("https://placeimg.com/#{@image_sizes.sample}/#{@image_sizes.sample}/#{@image_categories.sample}")
    end

    a.save
  end
end

puts "Creating Efforts"

Effort::KINDS.each do |kind|
  Effort.create(name: kind.to_s.split("_").join(" ").titleize, kind: kind, value: 20)
end

Effort::SPECIALS.each do |kind|
  Effort.create(name: kind.to_s.split("_").join(" ").titleize, kind: kind, value: 20)
end

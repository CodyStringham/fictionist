user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

# Make band members
band_members = ["Aaron Anderson", "Robbie Connolly", "Brandon Kitterman", "Stuart Maxfield"]
band_members.each do |member|
  User.invite! email: "#{member.split(' ').first}@fictionist.com", name: member, password: '123456789', role: 1 do |u|
    u.skip_invitation = true
  end
end

# Confirm band mambers
User.all.each do |u|
  u.accept_invitation!
end

# Band Members Content
@image_categories = %w( animals arch nature people tech )
@image_sizes = %w( 500 550 400 450 425 525 475 )

User.where(role: 1).each do |user|
  10.times do
    a = user.uploaded_contents.new
    a.message = Faker::Lorem.sentence
    a.published_at = Time.now
    a.view_permission = ['free', 'points'].sample
    a.asset = open("https://placeimg.com/#{@image_sizes.sample}/#{@image_sizes.sample}/#{@image_categories.sample}")
    a.save
  end
end



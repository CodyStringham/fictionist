user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

#make band members

band_members = ["Aaron Anderson", "Robbie Connolly", "Brandon Kitterman", "Stuart Maxfield"]
band_members.each do |member|
  User.create email: "#{member.split(' ').first}@fictionist.com", name: member, password: '123456789', role: 1
end

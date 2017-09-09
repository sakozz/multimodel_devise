namespace :multimodel_devise do
	desc "Create default admin user"
	task create_admin: :environment do
		raise "Usage: specify email address, e.g. rake [task] email=mail@caseincms.com [(optional) password=mypassword]" unless ENV.include?("email")
		password = ENV['password'] || SecureRandom.hex
		email = ENV['email']
		admin = MultimodelDevise::Admin.new({email: email, password: password, password_confirmation: password})

		unless admin.save!
			puts "[MultimodelDevise] Failed: check that the admin user with email '"+ email + "' doesn't already exist."
		else
			puts "[MultimodelDevise] Created new admin user with email '"+ email + "'  and password '#{password}'"
		end
	end
end
class UserMailer < ApplicationMailer
	default from: 'yashodhara@infiny.in'
 
	def welcome_email(target,random)
		@target = target
		@random= random
		@url  = 'http://example.com/login'
		mail(to: @target, subject: 'Welcome to My WebSite')
	end
end

require 'test_helper'

class CreateArticleTest < ActionDispatch::IntegrationTest
	
	def setup
		@user = User.create(username: "testme", email: "good@email.com", password: "test1234", admin: true)
	end
	
	test "get new article form and create article" do
		
	end
	
	test "invalid article name submission results in failure" do
		
	end


end
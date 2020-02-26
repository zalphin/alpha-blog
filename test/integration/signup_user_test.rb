require 'test_helper'

class SignupUserTest < ActionDispatch::IntegrationTest
	
	def setup
		
	end
	
	test "sign up user" do
		get signup_path
		assert_template 'users/new'
		assert_difference 'User.count', 1 do
			post users_path, params: { user: {username: "testme", email: "good@email.com", password: "password"}}
			follow_redirect!
		end
		assert_template 'users/show'
		assert_match "testme", response.body
	end
	
	test "bad username sign up" do
		get signup_path
		assert_template 'users/new'
		assert_no_difference 'User.count' do
			post users_path, params: { user: {username: "bd", email: "good@email.com", password: "password"}}
		end
		assert_template 'users/new'
		assert_select 'a', "Sign up"
	end
	
	test "bad email sign up" do
		get signup_path
		assert_template 'users/new'
		assert_no_difference 'User.count' do
			post users_path, params: { user: {username: "testme", email: "bademail.com", password: "password"}}
		end
		assert_template 'users/new'
		assert_select 'a', "Sign up"
	end
	
	test "bad password sign up" do
		get signup_path
		assert_template 'users/new'
		assert_no_difference 'User.count' do
			post users_path, params: { user: {username: "testme", email: "good@email.com", password: ""}}
		end
		assert_template 'users/new'
		assert_select 'a', "Sign up"
	end
end
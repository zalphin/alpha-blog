require 'test_helper'

class CreateArticleTest < ActionDispatch::IntegrationTest
	
	def setup
		@user = User.create(username: "testme", email: "good@email.com", password: "test1234")
	end
	
	test "get new article form and create article" do
		sign_in_as(@user, "test1234")
		get new_article_path
		assert_template 'articles/new'
		assert_difference 'Article.count', 1 do
			post articles_path, params: { article: { title: "test title", description: "Article description test"}}
			follow_redirect!
		end
		assert_template 'articles/show'
		assert_match "test title", response.body
	end

	test "error not logged in when getting new article form" do
		get new_article_path
		follow_redirect!
		assert_template 'pages/home'
		assert_select '#flash_danger'
	end

end
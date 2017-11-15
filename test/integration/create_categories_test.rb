require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)
  end

  test "get new category form and create category" do
    sign_in_as(@user, "password")
    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do
      #revisa que tengas una http post request al categories_path
      post categories_path, params: {category: {name: 'sports'}}
      follow_redirect!
    end
    #vemos que exista el template index
    assert_template 'categories/index'
    #esperamos que exista en el body devuelto la palabra sports
    assert_match "sports", response.body
  end

  test "invalid category submisions results in failure" do
    sign_in_as(@user, "password")
    get new_category_path
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do
      post categories_path, params: {category: {name: "  "}}
    end
    assert_template 'categories/new'
    #Buscando la existencia de estos dos elementos
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

end

require 'test_helper'

class DictionaryControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dictionary_index_url
    assert_response :success
  end

end

require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @book = books(:example _book)
  end

  test "Destroy when not logged in" do
    assert no_difference 'Book.count' do
      delete book_path(@book)
    end
    assert_response :see_other
    assert_redirect_to_login_url
  end
end

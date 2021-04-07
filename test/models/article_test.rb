require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  test "searches all Articles containing a query" do
    includes_query = Article.create! title: "Includes the query", content: <<~HTML
      <div>The text of this article matches has the needle in the haystack</div>
    HTML
    excludes_query = Article.create! title: "Excludes the query", content: <<~HTML
      <div>The text of this article matches is unrelated!</div>
    HTML

    search_results = Article.with_content_containing "needle in the haystack"

    assert_includes search_results.pluck(:title), includes_query.title
    assert_not_includes search_results.pluck(:title), excludes_query.title
  end

  test "queries ignore HTML debris" do
    includes_query = Article.create! title: "Includes the query", content: <<~HTML
      <div>The text of this article matches has the <strong>needle</strong> in the haystack</div>
    HTML

    search_results = Article.with_content_containing "needle in the haystack"

    assert_includes search_results.pluck(:title), includes_query.title
  end
end

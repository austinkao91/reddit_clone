module PostsHelper
  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_ids => [])
  end
end

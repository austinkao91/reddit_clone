module SubsHelper
  def subs_params
    params.require(:sub).permit(:title, :description)
  end
end

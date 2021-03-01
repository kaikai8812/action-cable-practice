class SearchController < ApplicationController
  def search
    @value = params[:value]
    @model = params[:model]
    @method = params[:method]
    
    if @model == "user"
      @datas = User.search_for(@value,@method)
    else
      @datas = Book.search_for(@value,@method)
    end
    binding.pry
  end
end

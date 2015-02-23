class Article
	 attr_accessor :likes, :dislikes
      attr_reader :title, :body, :author, :created_at
	
	 def initialize(title, body, author=nil)
    	@title=title
    	@body=body
    	@author=author
    	@created_at=Time.now
    	@likes=0
    	@dislikes=0
  	end
  
end
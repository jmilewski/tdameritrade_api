require 'open-uri'
class NokogiriController < ApplicationController

	def index
		# Parse the URI and retrieve it to a temporary file
		news_tmp_file = open('https://news.google.com')

		# Parse the contents of the temporary file as HTML
		doc = Nokogiri::HTML(news_tmp_file)

		# Define the css selectors to be used for extractions, most
		article_css_class         =".esc-layout-article-cell"
		article_header_css_class  ="span.titletext"
		article_summary_css_class =".esc-lead-snippet-wrapper"

		# extract all the articles 
		articles = doc.css(article_css_class)

		#html output
		html = ""

		#extract the title from the articles
		articles.each do |article|
		  title_nodes = article.css(article_header_css_class)

		  # since there are multiple titles for each entry on google news
		  # for this demo we only want the first (topmost)
		  #
		  # its very easy to do, since title_nodes is of type NodeSet which implements Enumerable (http://ruby-doc.org/core-2.0.0/Enumerable.html)
		  # > title_nodes.class
		  #  => Nokogiri::XML::NodeSet 
		  # > title_nodes.class.ancestors
		  #   => [Nokogiri::XML::NodeSet, Enumerable, Object, Kernel, BasicObject]

		  prime_title = title_nodes.first


		  # Even when the css selector returns only one element, its type is also Nokogiri::XML::NodeSet
		  summary_node = article.css(article_summary_css_class) 
		  # > summary_node.class
		  #  => Nokogiri::XML::NodeSet 
		  # > summary_node.size
		  #  => 1 

      # Create an "---------" line for the title
      separator = "-" * prime_title.text.size
  
		  # Extracting the text from an Nokogiri::XML::Element is easy by calling the #text method, 
		  # notice how we can also do it on the NodeSet, 
		  # there it as a different semantic by invoking #text in all the children nodes
  	  html += "%s\n%s\n%s\n\n\n" % [prime_title.text, separator, summary_node.text]
		end

		render :text => html,:content_type => "text/plain"
	end
end

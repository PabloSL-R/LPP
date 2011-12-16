#!/usr/bin/env ruby

class HTML
   attr_accessor :page
   
   def initialize(&block)
      @page = [[]]
      instance_eval &block
   end
   
   def build_attr(attributes)
      return '' if attributes.nil? or attributes.empty?
      s = ""
      attributes.each {|k,v| s += %{ #{k} = "#{v}"}}
      s
   end
   
   def method_missing(tag,*args)
      if block_given?
         @page.push []
         yield
         text = @page.pop.join " "
      else
         text = args.shift || "\n"
      end

      tagattr = build_attr(args.shift)
      text = "<#{tag}#{tagattr}>\n #{text}\n </#{tag}>"
      @page[-1].push text
   end
   
   def to_s
   	   @page.join("\n")
   end
   
end

if __FILE__ == $0
  q= HTML.new {  
    html {
          head(:dir => "chazam", :lang => "spanish") { title "My wonderful home page" }
          body do
	  h1 "Welcome to my home page!", :class => "chuchu", :lang => "spanish"
	  b "My hobbies:"
	  ul do
	    li "Juggling"
	    li "Knitting"
	    li "Metaprogramming"
          end #ul
        end # body
      }
    }
    puts q
end
         

#!/bin/env ruby
# encoding: utf-8

class Book
  
  attr_accessor :name
  attr_accessor :style
  
  def initialize name
    
    @name = name
    @pages = []
    @style = "
  @page { size: 5.5in 8.5in; }
  body { font-family:'Garamond'}
  page { page-break-after: always; border:1px solid black; display:block; padding:10px; width:400px; height:500px; position:relative; margin-bottom:30px; border-radius:3px}
  page id { position: absolute;bottom: 10px;display: block;text-align: center;width:100%;}"
    @increment = 0
    
  end

  def add_page page

    page.id = page.is_increment ? @increment += 1 : 0

    if page.style
      page.style.each do |tag,style|
        if @style.include?("page.#{page.type} #{tag}") then next end
        @style += "  page.#{page.type} #{tag} { #{style} }\n"  
      end
    end

    @pages.push(page)

  end
  
  def build
  
    puts "Generating.."

    content = "<style>\n#{@style}</style>\n\n"

    # Print pages
    count = 0
    @pages.each do |page|
      progress = (((count+1)/@pages.length.to_f)*100).to_i
      puts "#{progress}% Page: #{page.id} #{page.type}"
      content += page.to_s
      count += 1
    end

    # Create file
    out_file = File.new("#{@name}.html", "w")
    out_file.puts(content)
    out_file.close
    
    puts "Done."

  end
  
end
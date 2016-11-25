require 'rubygems'
require 'sinatra'
require 'sqlite3'

def get_db
  return SQLite3::Database.new  'barberShop.bd'
end

configure do
  db = get_db
  db.execute 'CREATE TABLE IF NOT EXISTS
       Users (
	              "id"	INTEGER PRIMARY KEY AUTOINCREMENT,
	              "name"	TEXT,
	              "phone" TEXT,
	              "dataStamp"	TEXT,
	              "Barber"	TEXT,
	              "color"	TEXT
              )'
end

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for"
end

get '/about' do
  erb :about
end

get '/visit' do
  erb :visit
end

post '/visit' do
    @user_name = params[:userName]
    @phone = params[:userPhone]
    @date_time = params[:dataTime]
    @select_barber = params[:selectBarber]
    @color = params[:colorVisitor]
    #
    #  hh = { :username => 'Enter name',
    #         :userPhone => 'Enter phone',
    #         :dataTime => 'Enter data and time'
    #       }
    #
    # @error = hh.select {|key,_| params[key] == ""}.values.join(", ")
    # if @error != ''
    #   return erb :visit
    # end


    db = get_db
    db.execute 'insert into
                  Users (
                        name,
                        phone,
                        dataStamp,
                        Barber,
                        color
                        )
                  values ( ?, ?, ?, ?, ? )',
                  [@user_name, @phone, @date_time, @select_barber, @color]
  erb :visit
end




 #    f = File.open './public/infoVisitor.txt', 'a'
 #     f.write "
 #             Visitor #{@user_name},
 #             Phone Visitor #{@phone},
 #             Data and time #{@data_time},
 #             Barber: #{@select_barber},
 #             Visitor choose color: #{@color}
 #            "
 #    f.close
 #
 #     erb :visit
 # end

get '/contacts' do
  erb :contacts
end

post '/contacts' do
      @email_visitor = params[:userEmail]
      @message_visitor = params[:messageVisitor]
    f = File.open './public/contacts.txt', 'a'
      f.write"
              Visitor email #{@email_visitor}
              Message Visitor: #{@message_visitor}
             "
      f.close
  erb :contacts
end


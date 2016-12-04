require 'rubygems'
require 'sinatra'
require 'sqlite3'

def is_barber_exists? db, namebarber
  db.execute('select * from Barbers where namebarber=?', [namebarber]).length > 0
end

def seed_db db, barbers
  barbers.each do |barber|
    if !is_barber_exists? db, barber
      db.execute 'insert into Barbers (namebarber) values (?)', [barber]
    end
  end
end

def get_db
  db = SQLite3::Database.new 'barberShop.db'
  db.results_as_hash = true
  return db
end

before do #иполняет код перед каждым запросом
 db = get_db
  @barbers = db.execute 'select * from Barbers'
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

  db.execute 'CREATE TABLE IF NOT EXISTS
       "Barbers" (
	              "id"	INTEGER PRIMARY KEY AUTOINCREMENT,
	              "namebarber"	TEXT
	            )'

  seed_db db, ['Walter White', 'Jessie Pinkman', 'Gus Fring', 'Mike Ehrmantraut']
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

  erb "<h1>Thank, you recorded</h1>"
end

get '/showusers' do

  db = get_db
  @results_users = db.execute 'select * from Users order by id desc'

  erb :showusers
end

post '/showusers' do

  db = get_db

  db.execute 'select * from Users' do |row|
    print row['name']
    print "\t-\t"
    print row['dataStamp']
    puts '========='
  end
end


get '/contacts' do
  erb :contacts
end

post '/contacts' do
  @email_visitor = params[:userEmail]
  @message_visitor = params[:messageVisitor]
  f = File.open './public/contacts.txt', 'a'
  f.write "
              Visitor email #{@email_visitor}
              Message Visitor: #{@message_visitor}
          "
  f.close
  erb :contacts
end


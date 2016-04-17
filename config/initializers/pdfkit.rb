PDFKit.configure do |config|
   # config.wkhtmltopdf = '/usr/local/bin/wkhtmltopdf'
   config.default_options = {
		:page_size => 'A4',
		:encoding=>"UTF-8",
		:print_media_type => true ,
		:quiet => false,

	}
end
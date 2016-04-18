PDFKit.configure do |config|
	# source file for Raspberry Pi downloaded here http://evilkitty.duckdns.org/wkhtmltopdf.7z
	# help fouded here https://github.com/wkhtmltopdf/wkhtmltopdf/issues/1868
   	config.wkhtmltopdf = '/usr/local/bin/wkhtmltopdf' if Rails.env.production?
   	config.default_options = {
		:page_size => 'A4',
		:encoding=>"UTF-8",
		:quiet => false
	}
end
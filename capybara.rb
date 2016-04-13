require 'capybara'
require 'capybara/dsl'
require 'spreadsheet'  

Capybara.run_server = false
Capybara.current_driver = :selenium
# Capybara.app_host = 'https://www.google.com'

Capybara.app_host = 'https://navlabsdev.appiancloud.com/suite'
tempo = '/tempo'
design = '/design'
designer = '/designer'

module NAV_TS_Test
	class TestRun
		include Capybara::DSL

		def sign_in(username, password)
			begin
				visit('/')
				fill_in 'un', :with => username
				fill_in 'pw', :with => password
				find('.button_box .btn.primary').click
			rescue
				raise Exception.new('Error signing in. Username: ' + username) 
			end
		end

		# def create_app(app_name)
		# 	visit('/design')
		# 	page.has_button?('New Application')
		# 	find_button('New Application').click

		# 	page.has_button?('Create')
		# 	fill_in 'Name', :with => app_name
		# 	find_button('Create').click
		# end

		def go_to_action(action_name)
			begin
				visit('/tempo')
				has_link?('Actions')
				click_link('Actions')
				has_link?(action_name)
				click_link(action_name)
			rescue
				raise Exception.new('Action not found: ' + action_name) 
			end
		end

		def go_to_task(task_name)
			begin
				visit('/tempo')
				has_link?('Tasks', options = {href: '/suite/tempo/tasks/'})
				click_link(find('a[href="/suite/tempo/tasks/"]').text)
				has_link?(task_name)
				click_link(task_name)
			rescue
				raise Exception.new('Task not found: ' + task_name) 
			end
		end

		def start_action(action_name, data)
			go_to_action(action_name)
			fill_out_form(data)
		end


		def complete_task(task_name, data)
			go_to_task(task_name)
			fill_out_form(data)
		end

		def fill_out_form(data)
			f = NAV_TS_Test::Form.new

			data.each_with_index do |component,i|
				f.fill_out component 
			end

		end

	end

	class Form
		include Capybara::DSL

		def fill_out(component)
			begin
				c_type = component[0]
				c_label = component[1]
				c_value = component[2]

				case c_type
				when 'Text'
					fill_in(c_label, :with => c_value)
				when 'Paragraph'
					fill_in(c_label, :with => c_value)
				when 'Decimal'
					fill_in(c_label, :with => c_value)
				when 'Integer'
					fill_in(c_label, :with => c_value)
				when 'Checkboxes'
					check(c_label)
				when 'Radio Buttons'
					choose(c_label)
				when 'Dropdown'
					find(:xpath, "//*[text()='" + c_label + "']/ancestor::*[@data-cid][1]//select").select(c_value)
				when 'Date'
					fill_in(c_label, :with => c_value)
				when 'Date & Time'
					fill_in(c_label, :with => c_value)
				when 'Time'
					fill_in(c_label, :with => c_value)


				when 'Multiple Dropdown'
					puts 'This is a ' + c_type
				when 'File Upload'
					puts 'This is a ' + c_type
				when 'Barcode'
					puts 'This is a ' + c_type


				when 'User Picker'
					fill_in(c_label, :with => c_value)
				when 'Group Picker'
					puts 'This is a ' + c_type				
				when 'Document Picker'
					puts 'This is a ' + c_type
				when 'Folder Picker'
					puts 'This is a ' + c_type
				when 'Custom Picker'
					puts 'This is a ' + c_type
				end
			rescue
				raise Exception.new('Component Error: ' + component.join(', '))
			end

		end
	end

	class TestScript    
		Spreadsheet.open('form-data.xls') do |book|
			book.worksheet('Sheet1').each do |row|
				break if row[0].nil?
				puts row.join(',')
			end
		end
	end

end

t = NAV_TS_Test::TestRun.new
t.sign_in('cpage','')

t.start_action('Create New Customer',
	[
		['Text','Stock Ticker','APPL'],
		['Text','Customer Name','Apple Computers'],
		# ['User Picker','Account Owner','Corbin Page'],
		['Dropdown','Industry','Other']
		])


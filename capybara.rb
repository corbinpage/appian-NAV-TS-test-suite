require 'json'
require 'csv'
require 'capybara'
require 'capybara/dsl'

Capybara.run_server = false
Capybara.current_driver = :selenium
# Capybara.app_host = 'https://www.google.com'

Capybara.app_host = 'https://navlabsdev.appiancloud.com/suite'
tempo = '/tempo'
design = '/design'
designer = '/designer'

module MyCapybaraTest
	class Test
		include Capybara::DSL

		def sign_in(username, password)
			visit('/')
			fill_in 'un', :with => username
			fill_in 'pw', :with => password
			find('.button_box .btn.primary').click
		end

		def create_app(app_name)
			visit('/design')
			page.has_button?('New Application')
			find_button('New Application').click

			page.has_button?('Create')
			fill_in 'Name', :with => app_name
			find_button('Create').click
		end

		def check_for_task(task_name)
			visit('/tempo')
			has_link?('Tasks', options = {href: '/suite/tempo/tasks/'})
			click_link('Tasks (4)')

			
		end


	end
end

t = MyCapybaraTest::Test.new
# t.log_objects('NAV_SA Starter Application')
# t.log_objects('NAV_TM Task Metric Utilities')
# t.create_copied_app('app-objects.csv', 'NAV_TM', 'ZZ_TEST')

t.sign_in('cpage','')
t.create_app('ZZ Test')
t.check_for_task('task_name')






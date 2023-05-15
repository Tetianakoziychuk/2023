from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By

# Set path to chromedriver executable
webdriver_service = Service('path/to/chromedriver')

# Set up Chrome options
chrome_options = webdriver.ChromeOptions()
chrome_options.add_argument('--headless')  # Run Chrome in headless mode (without opening browser window)

# Create a new instance of the Chrome driver
driver = webdriver.Chrome(service=webdriver_service, options=chrome_options)

# Navigate to the Shopify website
driver.get('https://www.shopify.com')

# Find the search input element and enter a keyword
search_input = driver.find_element(By.XPATH, '//input[@name="q"]')
search_input.send_keys('keyword')  # Replace 'keyword' with your desired search term
search_input.send_keys(Keys.RETURN)

# Wait for the search results to load
driver.implicitly_wait(5)

# Find and print the titles of the search results
search_results = driver.find_elements(By.XPATH, '//div[@class="result-title"]/a')
for result in search_results:
    print(result.text)

# Close the browser
driver.quit()

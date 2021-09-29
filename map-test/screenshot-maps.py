#%%
import os
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from selenium.webdriver.firefox.options import Options
options = Options()
import time
# %%
driver = webdriver.Firefox(executable_path='./geckodriver', firefox_options=options)
driver.get("http://localhost:3000/map")

delay = 1

themeSelect = WebDriverWait(driver, delay).until(EC.presence_of_element_located((By.ID, 'button--themeSelect')))
variableSelect = driver.find_element_by_id("button--variableSelect")
themeSelect.click()
themeOptions = driver.find_element_by_id("listbox--themeSelect").find_elements_by_css_selector("*")
themeSelect.click()
mapButtons = driver.find_elements_by_css_selector("button[class^='VariablePanel_pillButton']")

for i in range(2, len(themeOptions)):
    print()
    if (i == 0):
        pass
    else:
        themeSelect.click()
        currTheme = WebDriverWait(driver, delay).until(EC.presence_of_element_located((By.ID, themeOptions[i].get_attribute('id'))))
        currTheme.click()
    WebDriverWait(driver, delay).until(EC.presence_of_element_located((By.ID, themeOptions[i].get_attribute('id'))))
    variableSelect.click()
    variableOptions = driver.find_element_by_id("listbox--variableSelect").find_elements_by_css_selector("*")
    variableSelect.click()
    time.sleep(0.1)
    for n in range(0, len(variableOptions)):
        currVariable = WebDriverWait(driver, delay).until(EC.presence_of_element_located((By.ID, variableOptions[n].get_attribute('id'))))
        variableSelect.click()
        time.sleep(0.1)
        currVariable.click()
        WebDriverWait(driver, delay).until(EC.presence_of_element_located((By.ID, "button--themeSelect")))
        for button in mapButtons:
            if button.get_attribute("disabled") != 'true' or 'activeButton' in button.get_attribute("class"):
                time.sleep(delay/4)
                try:
                    button.click()
                    WebDriverWait(driver, delay).until(EC.presence_of_element_located((By.ID, variableOptions[n].get_attribute('id'))))
                    time.sleep(delay/4)
                    if 'Tract' in button.text or 'Zip' in button.text:
                        time.sleep(delay*3)
                    driver.save_screenshot(f"./screenshots/{variableOptions[n].get_attribute('data-value').replace('/','-')}_{button.text}.png")
                except:
                    print(f"Error on {button.text} on var {variableOptions[n].get_attribute('data-value')}")
driver.close()

# %%

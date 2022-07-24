from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from webdriver_manager.chrome import ChromeDriverManager
from bs4 import BeautifulSoup
import pandas as pd
import numpy as np

driver = webdriver.Chrome(ChromeDriverManager().install())
# driver.get("https://gardeningtips.in/top-50-vegetables-to-grow-in-the-backyard")
# soup = BeautifulSoup(driver.page_source, 'html.parser')

# vegetable_list = []

# main_divs = soup.find_all('div', class_='tdb-block-inner td-fix-index')[4]
# vegetables = main_divs.find_all('strong')
# for vegetable in vegetables:
#     vegetable_list.append(vegetable.text)

# vegetable_list = vegetable_list[5:len(vegetable_list)-7]
# vegetable_list = [x[:-2] for x in vegetable_list]

# vegetable_list.remove('How To Prepare Soil For Planting In Po')
# vegetable_list.remove('Easy Growing Flowers In Apartmen')
# vegetable_list.remove('Urban Gardening For Beginne')
# vegetable_list.remove('Bamboo Planting Ideas For Beginne')
# vegetable_list[3] = vegetable_list[3][:-1]

# print(vegetable_list)
# with open('vegetables.txt', 'w') as f:
#     for vegetable in vegetable_list:
#         f.write(vegetable + '\n')



# with open('vegetables-scientific.txt', 'r') as f:
#     vegetables = f.read().splitlines()


# for vegetable in vegetables:
#     driver.implicitly_wait(10)
#     driver.get(f"https://www.rhs.org.uk/plants/search-results?query={vegetable}")
#     soup = BeautifulSoup(driver.page_source, 'html.parser')
#     div1 = driver.find_elements(By.XPATH,"//*[@id='content']/app-root/app-plant-search-result-page/app-plant-listing/div/div/div/div[2]/app-plant-search-list")[0]
#     href_link = div1.find_element(By.CLASS_NAME, 'u-faux-block-link__overlay').get_attribute('href')
    
#     with open('links.txt','a' ) as f:
#         f.write(href_link + '\n')


temperature_tolerance_dict = {
    'H1a':15,
    'H1b':10,
    'H1c':5,
    'H2':1,
    'H3':-5,
    'H4':-10,
    'H5':-15,
    'H6':-20,
    'H7':-25,
}

plant_table = {
    'plant_scientific_name': [],
    'plant_name': [],
    'plant_description': [],
    'plant_type':[],
    'plant_size_max_height_lowest': [],
    'plant_size_max_height_highest': [],
    'plant_max_size_time_lowest': [],
    'plant_max_size_time_highest': [],
    'plant_size_max_spread_lowest':[],
    'plant_size_max_spread_highest': [],
    'plant_sun_exposer':[],
    'temperature_tolarence':[],
    'plant_how_to_cultivate':[],
    'plant_how_to_propagate':[],
    'plant_how_to_garden_type':[],
    'plant_how_to_pruning':[],
    'plant_how_to_pests':[],
    'plant_how_to_diseases':[],
    'soil':[],
    'plant_moisture_level':[],
    'ph_level':[],
}

soil = {
    'soil_type':["LOAM","SAND","CLAY","CHALK"],
}

moist_level = {
    'moist_level':["MOIST_BUT_WELL_DRAINED", "POORLY_DRAINED", "WELL_DRAINED"],
}

ph_level = {
    'ph_level':["ACIDIC","ALKALINE","NEUTRAL"],
}

soil_plant = {
    "soil_type_id": [],
    "plant_id": [],
}

moist_plant = {
    "moist_level_id": [],
    "plant_id": [],
}

ph_plant = {
    "ph_level_id": [],
    "plant_id": [],
}



ph_level = pd.DataFrame(ph_level)
ph_level.index = np.arange(1, len(ph_level) + 1)
print(ph_level)

moist_level = pd.DataFrame(moist_level)
moist_level.index = np.arange(1,len(moist_level)+1)
print(moist_level)

soil = pd.DataFrame(soil)
soil.index = np.arange(1,len(soil)+1)
print(soil)

soil_plant = pd.DataFrame(soil_plant)
soil_plant.index = np.arange(1,len(soil_plant)+1)

moist_plant = pd.DataFrame(moist_plant)
moist_plant.index = np.arange(1,len(moist_plant)+1)

ph_plant = pd.DataFrame(ph_plant)
ph_plant.index = np.arange(1,len(ph_plant)+1)

plant_table = pd.DataFrame(plant_table)

with open('links.txt', 'r') as f:
    links = f.read().splitlines()

for link in links:
    driver = webdriver.Chrome(ChromeDriverManager().install())
    driver.get(link)
    soup = BeautifulSoup(driver.page_source, 'html.parser')
    try:
        title_summ_div = soup.find_all('div', {"class" : 'l-module__content u-p-l-1-lg'})[0]
    except:
        title_summ_div = soup.find_all('div', {"class" : 'l-module__content'})[0]
            
    try:
        scientifc_name = title_summ_div.find_all('h1')[0].find_all('span')[0].text.split('\n')[0]
    # plant_table['plant_scientific_name'].append(scientifc_name)
    except:
        scientifc_name = np.NAN
    print(scientifc_name)

    try:
        normal_name = title_summ_div.find_all('p', {"class": "summary summary--sub"})[0].text.split('\n')[0]
    except:
        normal_name = np.NAN
    # plant_table['plant_title'].append(normal_name)
    print(normal_name)

    try:
        description = title_summ_div.find_all('p', {"class": "ng-star-inserted"})[0].text.split('\n')[0]
    except:
        description = np.NAN
    print(description)

    try:
        plant_type = soup.find_all('span',{"class":"label ng-star-inserted"})[0].text.split('\n')[0]
    except:
        plant_type = np.NAN
    print(plant_type)

    try:
        many_to_many_divs = soup.find_all('div', {"class": "plant-attributes__panel"})[1]
    except:
        pass

    try:
        temp_and_expo = soup.find_all('div', {"class": "plant-attributes__panel"})[3]
        
        temp_tolerance = temp_and_expo.find_all('div',{"class":"l-module"})[0]
        exposure = temp_and_expo.find_all('div',{"class":"l-col-xs-6 l-col-sm-6 l-col-md-6 l-col-lg-6 ng-star-inserted"})[0]
        

        temp_tolerance = temp_tolerance.text[len("Exposure"):]
        exposure_text = exposure.find_all('span')[-1].text
        exposure_value = temperature_tolerance_dict[exposure_text]

        print(temp_tolerance)
        print(exposure_value)

    except:
        print('no temp and expo')

    try:
        soil_div = many_to_many_divs.find_all('div', {"class": "l-row l-row--space l-row--compact l-row--auto-clear ng-star-inserted"})
        soils = soil_div[0].find_all('div', {"class": "flag__body"})
    except:
        pass

    soil_list = []
    try:
        for soil_name in soils:
            soil_id = soil[soil['soil_type']==soil_name.text.upper()].index.values
            print(soil_id)
            print(len(plant_table)+1)
            soil_temp_df = {"soil_type_id": [int(soil_id[0])], "plant_id": [int(len(plant_table)+1)]}
            soil_list.append(int(soil_id[0]))
            soil_temp_df = pd.DataFrame(soil_temp_df)
            soil_plant = soil_plant.append(soil_temp_df)
    except:
        soil_id = np.NAN
        soil_temp_df = {"soil_type_id": [soil_id], "plant_id": [int(len(plant_table)+1)]}
        soil_temp_df = pd.DataFrame(soil_temp_df)
        soil_list.append(soil_id)
        soil_plant = soil_plant.append(soil_temp_df)

    try:
        moist_ph_div = many_to_many_divs.find_all('div', {"class": "l-row l-row--space l-row--auto-clear"})
    except:
        pass
    
    moist_list = []
    moist = moist_ph_div[0].find_all('div', {"class": "l-col-xs-6 l-col-sm-6 l-col-md-6 l-col-lg-6 ng-star-inserted"})[0].find_all('span')
    try:
        for moist_name in moist:
            moist_name = moist_name.text
            if moist_name[-2] == ',':
                moist_name = moist_name[:len(moist_name)-2]
            
            print(moist_name)
            
            if moist_name == 'Moist but well–drained':
                moist_name = 'MOIST_BUT_WELL_DRAINED'
            elif moist_name == 'Poorly–drained':
                moist_name = 'POORLY_DRAINED'
            elif moist_name == 'Well–drained':
                moist_name = 'WELL_DRAINED'

            moist_id = moist_level[moist_level['moist_level']==moist_name].index.values
            print(moist_id)
            moist_list.append(int(moist_id[0]))
            moist_temp_df = {"moist_level_id": [int(moist_id[0])], "plant_id": [int(len(plant_table)+1)]}
            moist_temp_df = pd.DataFrame(moist_temp_df)
            moist_plant = moist_plant.append(moist_temp_df)
    except:
        moist_id = np.NAN
        moist_list.append(moist_id)
        moist_temp_df = {"moist_level_id": [moist_id], "plant_id": [int(len(plant_table)+1)]}
        moist_temp_df = pd.DataFrame(moist_temp_df)
        moist_plant = moist_plant.append(moist_temp_df)

    ph_list = []
    ph = moist_ph_div[0].find_all('div', {"class": "l-col-xs-6 l-col-sm-6 l-col-md-6 l-col-lg-6 ng-star-inserted"})[1].find_all('span')
    try:
        for ph_name in ph:
            ph_name = ph_name.text
            if ph_name[-2] == ',':
                ph_name = ph_name[:len(ph_name)-2]
            
            if ph_name == 'Acid':
                ph_name = 'ACIDIC'
            elif ph_name == 'Neutral':
                ph_name = 'NEUTRAL'
            elif ph_name == 'Alkaline':
                ph_name = 'ALKALINE'
            else:
                print('error')

            ph_id = ph_level[ph_level['ph_level']==ph_name].index.values
            ph_list.append(int(ph_id[0]))
            ph_temp_df = {"ph_level_id": [int(ph_id[0])], "plant_id": [int(len(plant_table)+1)]}
            ph_temp_df = pd.DataFrame(ph_temp_df)
            ph_plant = ph_plant.append(ph_temp_df)
    except:
        ph_id = np.NAN
        ph_level.append(ph_id)
        ph_temp_df = {"ph_level_id": [ph_id], "plant_id": [int(len(plant_table)+1)]}
        ph_temp_df = pd.DataFrame(ph_temp_df)
        ph_plant = ph_plant.append(ph_temp_df)

    try:
        plant_size_max_height = soup.find_all('div',{"class":"flag__body"})[0].text
        plant_size_max_height = plant_size_max_height.split(" ")[2]
    except:
        pass

    try:
        if len(plant_size_max_height.split('–')) == 1:
            plant_size_max_height_highest = plant_size_max_height[0]
            plant_size_max_height_lowest = plant_size_max_height[0]
        else:
            plant_size_max_height_lowest = plant_size_max_height.split('–')[0]
            plant_size_max_height_highest = plant_size_max_height.split('–')[1]
    except:
        plant_size_max_height_highest = np.NAN
        plant_size_max_height_lowest = np.NAN
    
    print(plant_size_max_height_lowest)
    print(plant_size_max_height_highest)

    try:
        plant_max_time = soup.find_all('div',{"class":"flag__body"})[1].text
        plant_max_time = plant_max_time.split(" ")[4]
        plant_max_time = plant_max_time.split('–')
        if len(plant_max_time)==1:
            plant_max_time_lowest = plant_max_time[0]
            plant_max_time_highest = plant_max_time[0]
        else:
            plant_max_time_lowest = plant_max_time[0]
            plant_max_time_highest = plant_max_time[1]
        print(plant_max_time_lowest)
        print(plant_max_time_highest)
    except:
        plant_max_time_lowest = np.NAN
        plant_max_time_highest = np.NAN

    try:
        plant_size_max_spread = soup.find_all('div',{"class":"flag__body"})[2].text
        plant_size_max_spread = plant_size_max_spread.split(" ")[2]
        plant_size_max_spread = plant_size_max_spread.split('–')
        if len(plant_size_max_spread)==1:
            plant_size_max_spread_lowest = plant_size_max_spread[0]
            plant_size_max_spread_highest = plant_size_max_spread[0]
        else:
            plant_size_max_spread_lowest = plant_size_max_spread[0]
            plant_size_max_spread_highest = plant_size_max_spread[1]
    except:
        print('error')

    try:
        sun_exposer_list = soup.find_all('ul',{"class":"list-inline ng-star-inserted"})[0].find_all('li')
        sun_exposer = str()
        if len(sun_exposer_list)>1:
            sun_exposer = "FULL_OR_PARTIAL_SUN"
            print(sun_exposer_list[0].text)
            print(sun_exposer_list[1].text)
        else:
            if sun_exposer_list[0].text=="Full Sun":
                sun_exposer = "FULL_SUN"
            else:
                sun_exposer = "PARTIAL_SUN"
            print(sun_exposer_list[0].text)
    except:
        sun_exposer = np.NAN

    try:
        cultivate = soup.find_all('div',{"class":"content"})[1]
        cultivate_new = cultivate.find_all('span',{"class":"ng-star-inserted"})[0]
    except:
        pass

    try:
        plant_how_to_culitvate = cultivate_new.text[11:]
    except:
        plant_how_to_culitvate = np.NAN

    try:
        propagation = cultivate.find_all('span',{"class":"ng-star-inserted"})[1]
    except:
        pass

    try:
        plant_how_to_propagate = propagation.text[11:]
    except:
        plant_how_to_propagate = np.NAN

    try:
        garden_types = cultivate.find_all('span',{"class":"ng-star-inserted"})[2].find_all('ul')[0].find_all('li')
        plant_how_to_garden = []
        for garden_type in garden_types:
            plant_how_to_garden.append(garden_type.text)
    except:
        plant_how_to_garden = np.NAN
    print(plant_how_to_garden)
    
    try:
        pruning = cultivate.find_all('span',{"class":"ng-star-inserted"})[3]
        plant_how_to_pruning = pruning.text[7:]
    except:
        plant_how_to_pruning = np.NAN
    print(plant_how_to_pruning)

    try:
        pests = cultivate.find_all('span',{"class":"ng-star-inserted"})[4]
        plant_how_to_pests = pests.text[5:]
    except:
        plant_how_to_pests = np.NAN

    try:
        diseases = cultivate.find_all('span',{"class":"ng-star-inserted"})[5]
        plant_how_to_diseases = diseases.text[8:]
    except:
        plant_how_to_diseases = np.NAN



    temp_df = {"plant_scientific_name": [scientifc_name],"plant_name": [normal_name],"plant_description": [description],
    "plant_type": [plant_type],"plant_size_max_height_lowest": [plant_size_max_height_lowest],"plant_size_max_height_highest": [plant_size_max_height_highest],
    "plant_max_size_time_lowest": [plant_max_time_lowest],"plant_max_size_time_highest": [plant_max_time_highest],"plant_sun_exposer": [sun_exposer],
    "plant_how_to_cultivate": [plant_how_to_culitvate],"plant_how_to_propagate": [plant_how_to_propagate],"plant_how_to_garden_type":[plant_how_to_garden],"plant_how_to_pruning":[plant_how_to_pruning],"plant_how_to_pests": [plant_how_to_pests],
    "plant_how_to_diseases": [plant_how_to_diseases], "temperature_tolarence":[temp_tolerance],""
    "soil":[soil_list],'plant_moisture_level':[moist_list],'ph_level':[ph_list],"weather_exposer":[exposure_value],
    "plant_size_max_spread_lowest":[plant_size_max_spread_lowest],"plant_size_max_spread_highest":[plant_size_max_spread_highest],"plant_harvest_length":[np.NAN],"planting_season":[np.NAN],"plant_harvest_season":[np.NAN]}
    
    plant_table = plant_table.append(pd.DataFrame(temp_df))

    plant_table.index = np.arange(1, len(plant_table)+1)
    
    print(plant_table)
    
    

print(plant_table)
plant_table.to_json("plant_table.json")
plant_table.to_csv("plant_table.csv")
plant_table.to_csv('plant_table.csv')
soil_plant.to_csv('soil_plant.csv')
moist_plant.to_csv('moist_plant.csv')
ph_plant.to_csv('ph_plant.csv')
# plant_table.to_excel("plant_table.xlsx")
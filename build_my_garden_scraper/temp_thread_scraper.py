import pandas as pd
from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.common.by import By
from bs4 import BeautifulSoup
import numpy as np
from selenium.webdriver.common.action_chains import ActionChains
import concurrent.futures

# Information needed : 
# Plant title, 
# Plant description, 
# Plant image,
# Plant characteristics,
    # Plant type
    # Plant lifespan
    # Plant harvest time
    # Plant heigh
    # Plant width

# Plant condition
    # Sunlight
    # Temperature
    # Soil
    # Water

# Plant care instructions
    # Watering
    # Fertilizing
    # Pest control*
    # Pruning*
    # Harvesting

# Plant location

# Write comments for each section
# * = not all plants have these features
plant_table = {
    'plant_scientific_name': [],
    'plant_title': [],
    'plant_description': [],
    'plant_type':[],
    'plant_size_max_height_lowest': [],
    'plant_size_max_height_highest': [],
    'plant_max_time_lowest': [],
    'plant_max_time_highest': [],
    'sun_exposer':[],
    'plant_how_to_cultivate':[],
    'plant_how_to_propagate':[],
    'plant_how_to_garden_type':[],
    'plant_how_to_pruning':[],
    'plant_how_to_pests':[],
    'plant_how_to_diseases':[]
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
index = 1

pageSize = 100
# startFrom = 0

def web_crapper(begin, end):
    
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
    index = 1

    pageSize = 100

    index = 1
    # 0, 1100, 100
    #
    # 
    for startFrom in range(begin, end, 100):
        driver = webdriver.Chrome("build_my_garden_scraper\chrome_driver\chromedriver.exe")
        action = ActionChains(driver)
        driver.get(f'https://www.rhs.org.uk/plants/search-results?plantTypes=7,12,13&pageSize={pageSize}&startFrom={startFrom}')
        # print(driver.page_source)
        div1 = driver.find_elements(By.XPATH,"//*[@id='content']/app-root/app-plant-search-result-page/app-plant-listing/div/div/div/div[2]/app-plant-search-list")
        if len(div1)!=0:
            driver.implicitly_wait(2)
            uls = div1[0].find_elements(By.TAG_NAME, 'ul')
        print(len(uls))
        lis = []

        if len(uls)>0:
            ul = uls[0]
            lis.append(ul.find_elements(By.TAG_NAME, "li"))

        driver.implicitly_wait(2)
        for li in lis[0]:

            outer_path = li.find_elements(By.CLASS_NAME,"u-faux-block-link__overlay")
            if len(outer_path)>0:
                plant_index = index
                index += 1

                href_link = outer_path[0].get_attribute('href')
                new_driver = webdriver.Chrome(ChromeDriverManager().install())
                new_driver.get(href_link)
                soup = BeautifulSoup(new_driver.page_source, 'html.parser')
                title_summ_div = soup.find_all('div', {"class" : 'l-module__content u-p-l-1-lg'})[0]

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

                many_to_many_divs = soup.find_all('div', {"class": "plant-attributes__panel"})[1]

                soil_div = many_to_many_divs.find_all('div', {"class": "l-row l-row--space l-row--compact l-row--auto-clear ng-star-inserted"})
                soils = soil_div[0].find_all('div', {"class": "flag__body"})
                try:
                    for soil_name in soils:
                        soil_id = soil[soil['soil_type']==soil_name.text.upper()].index.values
                        print(soil_id)
                        print(plant_index)
                        soil_temp_df = {"soil_type_id": [int(soil_id[0])], "plant_id": [int(plant_index)]}
                        soil_temp_df = pd.DataFrame(soil_temp_df)
                        soil_plant = soil_plant.append(soil_temp_df)
                except:
                    soil_id = np.NAN
                    soil_temp_df = {"soil_type_id": [soil_id], "plant_id": [int(plant_index)]}
                    soil_temp_df = pd.DataFrame(soil_temp_df)
                    soil_plant = soil_plant.append(soil_temp_df)

                moist_ph_div = many_to_many_divs.find_all('div', {"class": "l-row l-row--space l-row--auto-clear"})

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
                        moist_temp_df = {"moist_level_id": [int(moist_id[0])], "plant_id": [int(plant_index)]}
                        moist_temp_df = pd.DataFrame(moist_temp_df)
                        moist_plant = moist_plant.append(moist_temp_df)
                except:
                    moist_id = np.NAN
                    moist_temp_df = {"moist_level_id": [moist_id], "plant_id": [int(plant_index)]}
                    moist_temp_df = pd.DataFrame(moist_temp_df)
                    moist_plant = moist_plant.append(moist_temp_df)


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
                        ph_temp_df = {"ph_level_id": [int(ph_id[0])], "plant_id": [int(plant_index)]}
                        ph_temp_df = pd.DataFrame(ph_temp_df)
                        ph_plant = ph_plant.append(ph_temp_df)
                except:
                    ph_id = np.NAN
                    ph_temp_df = {"ph_level_id": [ph_id], "plant_id": [int(plant_index)]}
                    ph_temp_df = pd.DataFrame(ph_temp_df)
                    ph_plant = ph_plant.append(ph_temp_df)

                plant_size_max_height = soup.find_all('div',{"class":"flag__body"})[0].text
                plant_size_max_height = plant_size_max_height.split(" ")[2]

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

                cultivate = soup.find_all('div',{"class":"content"})[1]
                cultivate_new = cultivate.find_all('span',{"class":"ng-star-inserted"})[0]

                try:
                    plant_how_to_culitvate = cultivate_new.text[11:]
                except:
                    plant_how_to_culitvate = np.NAN

                propagation = cultivate.find_all('span',{"class":"ng-star-inserted"})[1]
                try:
                    plant_how_to_propagate = propagation.text[11:]
                except:
                    plant_how_to_propagate = np.NAN

                try:
                    garden_types = cultivate.find_all('span',{"class":"ng-star-inserted"})[2].find_all('ul')[0].find_all('li')
                    plant_how_to_garden = []
                    for garden_type in garden_types:
                        plant_how_to_garden.append(garden_type.text)
                    plant_how_to_garden = ",".join(plant_how_to_garden)
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



                temp_df = {"plant_scientific_name": [scientifc_name],"plant_title": [normal_name],"plant_description": [description],
                "plant_type": [plant_type],"plant_size_max_height_lowest": [plant_size_max_height_lowest],"plant_size_max_height_highest": [plant_size_max_height_highest],
                "plant_max_time_lowest": [plant_max_time_lowest],"plant_max_time_highest": [plant_max_time_highest],"plant_sun_exposer": [sun_exposer],
                "plant_how_to_culitvate": [plant_how_to_culitvate],"plant_how_to_propagate": [plant_how_to_propagate],"plant_how_to_garden_type":[plant_how_to_garden],"plant_how_to_pruning":[plant_how_to_pruning],"plant_how_to_pests": [plant_how_to_pests],"plant_how_to_diseases":[plant_how_to_diseases]}

                plant_table = plant_table.append(pd.DataFrame(temp_df))

                plant_table.index = np.arange(1, plant_index)

                print(plant_table)



    driver.quit()

with concurrent.futures.ThreadPoolExecutor(max_workers=4) as executor:
        begin = [x for x in range(0,8000,2000)]
        print(begin)
        end = [x for x in range(2001, 8002, 2000)]
        print(end)

        results = executor.map(web_crapper, begin, end)

        for result in results:
            print("Done " + str(result))

soil_plant.index = np.arange(1, len(soil_plant)+1)
moist_plant.index = np.arange(1, len(moist_plant)+1)
ph_plant.index = np.arange(1, len(ph_plant)+1)

print(plant_table)
print(soil_plant)
print(moist_plant)
print(ph_plant)

plant_table.to_csv('plant_table.csv')
soil_plant.to_csv('soil_plant.csv')
moist_plant.to_csv('moist_plant.csv')
ph_plant.to_csv('ph_plant.csv')
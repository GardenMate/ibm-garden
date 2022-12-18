from ibm_watson import LanguageTranslatorV3
from ibm_cloud_sdk_core.authenticators import IAMAuthenticator
import json
import os
from dotenv import load_dotenv

load_dotenv()

apikey = os.getenv("API_KEY")
url = os.getenv("url")

authenticator = IAMAuthenticator(f'{apikey}')
language_translator = LanguageTranslatorV3(
    version='2018-05-01',
    authenticator=authenticator
)

language_translator.set_service_url(f'{url}')

list_str = [
    "Sustainable Farming Practices",
    "Homemade Compost from your Kitchen",
    "Boxed Planting for Urban areas",
    "Save your Soil"
  ]

spanish_list = []

for x in list_str:

    translation = language_translator.translate(text=x, model_id="en-es").get_result()
    spanish_list.append(translation['translations'][0]['translation'])


print(spanish_list)

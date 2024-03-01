import requests
import pandas as pd

# dataframe to store country info
country_data = pd.DataFrame(columns=['Country', 'Capital', 'Population'])

# get country info
def get_country_info(country_name):
    try:
        # API call to get country info
        response = requests.get(f'https://restcountries.com/v3.1/name/{country_name}')
        # raise error if response does not match
        response.raise_for_status()
        data = response.json()

        # get common name, capital, and population
        common_name = data[0]['name']['common']
        capital = data[0]['capital'][0] if 'capital' in data[0] else 'No Capital'
        population = data[0]['population']
        return common_name, capital, population
    # print error statement if input is wrong
    except requests.exceptions.HTTPError:
        print("Could not find information for the specified country. Please check your input.")
    except requests.exceptions.RequestException as e:
        print(f"An error occurred: {e}")

while True:
    country_name = input("Enter a country name (or type 'exit' to quit): ").strip()
    if country_name.lower() == 'exit':
        break
    common_name, capital, population = get_country_info(country_name)
    if common_name and capital and population:
        print(f"Country: {common_name}, Capital: {capital}, Population: {population}")
        # add to dataframe
        new_row = pd.DataFrame({'Country': [common_name], 'Capital': [capital], 'Population': [population]})
        country_data = pd.concat([country_data, new_row], ignore_index=True)

# write to json file
country_data.to_json('country_info.json', orient='records', lines=True, mode='a')
#print("Country information added to country_info.json.")
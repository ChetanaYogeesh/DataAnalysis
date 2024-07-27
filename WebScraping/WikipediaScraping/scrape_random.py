'''
The provided script is a web scraper designed to download random Wikipedia articles. The script automates the process of fetching and saving random Wikipedia articles to a specified directory, 
handling up to 3000 articles, with proper error handling and rate limiting to ensure responsible scraping practices.

Here is a summary of what the script does:

1. Imports Necessary Libraries**: The script imports 'requests' for making HTTP requests, 'time' for adding delays, and 'os' for handling file paths and directory creation.

2. Configuration**:
   - Sets the maximum number of articles to download ('file_max') to 3000.
   - Initializes a counter ('counter') to keep track of the number of downloaded articles.
   - Defines the URL for fetching random Wikipedia articles ('random_url').
   - Sets the directory ('save_dir') where the downloaded articles will be saved.

3. Ensure Directory Exists**: Uses 'os.makedirs' to create the target directory if it does not already exist.

4. Main Loop**: Runs a loop to download articles until the specified maximum number ('file_max') is reached.
   - Prints progress every 1000 articles.
   - Makes an HTTP GET request to fetch a random Wikipedia article.
   - Decodes the content of the article.
   - Extracts the article's title from the URL.
   - Writes the content to a file named after the article's title, saved in the specified directory.
   - Increments the counter after each successful download.
   - Handles exceptions and prints error messages if any occur.
   - Pauses for 1.5 seconds between requests to avoid overloading the server.
'''


import requests
import time
import os

# Maximum number of files to download
file_max = 3000
counter = 0

# URL to fetch random Wikipedia articles
random_url = "http://en.wikipedia.org/wiki/Special:Random"

# Directory to save downloaded articles
save_dir = os.path.expanduser("~/Documents/GitHub/Data/wiki")

# Ensure the directory exists
os.makedirs(save_dir, exist_ok=True)

while counter < file_max:
    if counter % 1000 == 0:
        print(f"On {counter}")

    try:
        # Fetch the random Wikipedia page
        response = requests.get(random_url)
        response.raise_for_status()  # Raise an error for bad status codes
        
        # Decode the content
        content = response.content.decode("utf-8")
        
        if content:
            # Extract the article title from the URL
            title = response.url.split("/")[-1]
            
            # Define the file path
            file_path = os.path.join(save_dir, f"{title}.html")
            
            # Save the content to a file
            with open(file_path, "w", encoding="utf-8") as file:
                file.write(content)
                counter += 1

    except requests.RequestException as e:
        print(f"Request error: {e}")
    except Exception as e:
        print(f"General error: {e}")
    
    # Wait for 1.5 seconds to avoid overloading the server
    time.sleep(1.5)

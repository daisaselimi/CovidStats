
# CovidStats

CovidStats is a project that I started to learn more about SwiftUI framework.

It uses a public API to fetch general data for COVID-19 through [RapidApi](https://rapidapi.com)

##### _Please note that this app could not be published for external testing in TestFlight, and it can't be published through App Store either. Apple's reference:_
> Since the COVID-19 pandemic is a public health crisis, services and information related to it are considered to be part of the healthcare industry.

##### 
##  Features

- Check total statictics, global-level
  - Confirmed
  - Recovered
  - Critical
  - Deaths
  - Death percentage
  - Recovery percentage
- A list with each country and basic statistics related to it
  - Confirmed
  - Deaths
  - Recovered
 - Additional statistics for each country, when clicked in the list mentioned above:
     - Confirmed
     - Recovered
     - Active cases
     - New cases
     - Critical
     - Total deaths
     - New deaths
     - Fatality rate
     - Recovery rate
     - Total tests
          -  _As the API that provides these statistics does not include all countries, some of them do not have all the statistics mentioned above_
- A map with an annotation in each country, showing confirmed and recovered cases.
   - Annotations can be toggled to show Confirmed/Recovered and Confirmed/Deaths.
 - Other
     - Search for a country to check all its related statistics

## Preview

<p align="center" markdown="1">
<img src="https://imgur.com/aLn0bB9.png" width="300" />
<img src="https://imgur.com/YwcHHda.png" width="300"/>
<img src="https://imgur.com/6J436TV.png" width="300"/>
<img src="https://imgur.com/KjMZVSp.png" width="300"/>
<img src="https://imgur.com/HsBrUKF.png" width="300"/>
<img src="https://imgur.com/q2xKSnL.png" width="300"/>
</p>


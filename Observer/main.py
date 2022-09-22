from weatherreport.dashboard import Dashboard
from weatherreport.weather import Weather


if __name__=="__main__":
    mainDasboard = Dashboard("Main")
    mobileDashboard = Dashboard("Mobile")
    
    weatherDublin = Weather("Dublin")
    weatherMadrid = Weather("Madrid")
    weatherNY = Weather("NY")
    
    weatherNY.attach_observer(mobileDashboard)
    weatherDublin.attach_observer(mobileDashboard)
    
    weatherNY.attach_observer(mainDasboard)
    weatherDublin.attach_observer(mainDasboard)
    weatherMadrid.attach_observer(mainDasboard)
    
    # Changes happen and observers are notified
    
    weatherMadrid.notify_changes("27ºC")
    weatherDublin.notify_changes("15ºC")
    weatherNY.notify_changes("9ºC")
    
    # Remove observer and make changes
    
    print("Removing observer from WeatherNY")
    
    weatherNY.remove_observer(mainDasboard)
    
    weatherMadrid.notify_changes("28ºC")
    weatherDublin.notify_changes("16ºC")
    weatherNY.notify_changes("10ºC")
    
    
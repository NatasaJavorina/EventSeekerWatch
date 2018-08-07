# EventSeekerWatch
Apple Watch app created based on the Ticketmaster API


The app is performing a location based event search within a fixed radius of 10km around the user, showing map location and event details.  

After choosing the event, the user can click on Buy Ticket button that opens the default browser on users smartphone and enables the user to buy a ticket for the specific event through the website.



This app was created in order to practice parsing JSON and location services, as well as learning how to work with the Watch extension. 

Here is the tutorial that helped me getting started with the WatchOS.

https://www.raywenderlich.com/170177/watchos-4-tutorial-part-1-getting-started


Getting started with the simulator

Before running the app on the simulator, you have to chose the Watch Target.

![alt text](https://i.imgur.com/Dr6UVW3.png)

If the app is not starting on the apple watch simulator, it might be necessary to open the Maps app on the iPhone simulator and Allow using the location.

![alt text](https://i.imgur.com/oCeHTiB.png)

Allow location tab should also be checked in the EventSeeker app upon opening it on the iPhone. 

![alt text](https://i.imgur.com/jly6Q92.png)

If you have issues with the “Error Domain=kCLErrorDomain Code=0” error, select the simulator -> Debug -> Location -> Custom Location and enter some coordinates (Ticketmaster API is not available in the entire world, so make sure they exist in the giver area). 

![alt text](https://i.imgur.com/Sh1Y1Jd.png)



* If everything works fine, the app should look like this: 

![alt text](https://i.imgur.com/1OXoh60.png)
![alt text](https://i.imgur.com/fdTly6m.png)
![alt text](https://i.imgur.com/a0w3lhR.png)
![alt text](https://i.imgur.com/HzPc3YW.png)
![alt text](https://i.imgur.com/3v0zZvq.png)



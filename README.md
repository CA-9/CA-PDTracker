# CA-PDTracker
A police tracking device to track any vehicle. The device can only be used near the vehicle, and is valid for the police rank only. The device lasts for five minutes and then breaks down.

**To add the car_tracker item 
Go to qb-core/shared/items.lua**

``` 
--CA vehicle tracker
    ["car_tracker"] = {
    ["name"] = "car_tracker",
    ["label"] = "Vehicle tracking device",
    ["weight"] = 4,
    ["type"] = "item",
    ["image"] = "car_tracker.png",
    ["unique"] = true,
    ["useable"] = true,
    ["shouldClose"] = true,
    ["description"] = "Use it to track vehicles",
},

```

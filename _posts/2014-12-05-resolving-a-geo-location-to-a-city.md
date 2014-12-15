---
layout: post
title: "Resolving a geo-location to a city"
modified: 2014-12-12 17:04:28 -0200
tags: [geocode, city, web-api, foursquare, twofishes, geonames, openstreetmap, opencage]
image:
  feature: 
  credit: 
  creditlink: 
comments: 
share: 
---

The last week I was looking a way to find out the city from a latitude and longitude.
So here is what I learned.


##Circumstances

Actualy I and my team triped in this issue, because we are using the venues from the Foursquare API, that doesn't always provide this informations, and when it does may be roungh.
So I strugle in some insatisfary solutions, between those I've tested Geonames Onpenstreemap and  Mapbpx API.
Finaly it led me to the beta service of Opencage, that uses the Towfishes to resolve the geocode reverse.

I'm currently using the Mapbox map to display the Foursquare venues, and the Geoname api to auto complete cities names on a search form.
It shouldn't be hard at all, if it isn't the fact we can't use the Google api, because its license agreement obligate us to use from its own map.

##Developing acess to the APIs

The ideal scenario would use the Geoname API, because it's free service, we are already using, so the city aliases would be similar to the searched venues input.

As I've already experienced previously, it results don't follow a strict pattern, but tried it again to be sure.

As an alternative I've chosen to test the Mapbox api, that we already have an account, and the Openstreetmap, that doesn't require any account.

In oder to develop test the APIs, I've coded an Angular Webapp  using a template from Yeoman.

##Implementation

Then I develop a service that would use all those APIs.

To configure the service I've added constant to the angular module as follow. 

{% highlight js %}
reverseGeocodeModule.constant('GeoAPIConstants', {
    mapBoxId: 'xxxxxx',
    geonameId: 'xxxxxx',
    openCage: 'xxxxxx'
  });
{% endhighlight %}

When I developed the services, I used these constants to identify the environment configurations, so I don't need to peek on every file to change my access accounts.   

Let me show the services.

###Mapbox

The Mapbox WEB API has [this reverse geocode call](http://api.tiles.mapbox.com/v3/examples.map-zr0njcqy/geocode/-73.989,40.733.json).


{% highlight js %}
reverseGeocodeModule.service('MapboxService', [ '$http','GeoAPIConstants',
  function($http,GeoAPIConstants){
    var self = this;
    var urls = {};
    urls.geocode = "http://api.tiles.mapbox.com/v3/{0}/geocode/{1},{2}.json";
    self.FindCityReverseGeocode = function(lng, lat){
      var q = $http.get(urls.geocode.format(GeoAPIConstants.mapBoxId,lng,lat));
        return q.then(function(r){
                    return self.extractCityFromGeocodeJSONResult(r.data);
        });
      };
    self.extractCityFromGeocodeJSONResult = function(result){
      if(self.isResultEmpty(result))
        return null;
      return self.searchInMatrixForCity(result);
    };
    self.isResultEmpty = function(result){
      return !result.results || result.results.length === 0;
    }
    self.searchInMatrixForCity = function(result){
      for(var i = 0; i < result.results.length; i++){
        for(var j = 0; j < result.results.length; j++){
          if(result.results[i][j].type == 'city')
            return result.results[i][j];
        }
      }
      return null;
    }
  }]);
{% endhighlight %}


###Openstreetmap

{% highlight js %}
reverseGeocodeModule.service('OpenstreetmapService', [ '$http',
  function($http){
    var self = this;
    var urls = {};
    urls.geocode = "http://nominatim.openstreetmap.org/reverse?format=json&lat={1}&lon={0}";
    self.FindCityReverseGeocode = function(lng, lat){
            return $http.get(urls.geocode.format(lng,lat));
    };
  }]);
{% endhighlight %}

###Geonames

{% highlight js %}
reverseGeocodeModule.service('GeonamesService', [ '$http','GeoAPIConstants',
  function($http,GeoAPIConstants){
    var self = this;
    var urls = {};
    urls.reverseGeocode = "http://ws.geonames.org/findNearbyPlaceNameJSON?lat={1}&lng={0}&style=full&username={2}";

    self.FindCityReverseGeocode = function(lng, lat){
            var q = $http.get(urls.reverseGeocode.format(lng,lat,GeoAPIConstants.geonameId));
            return q.then(function(result){
                var listResults = result.data.geonames;
                for(var i = 0; i < listResults.length; i++){
                    if(0<=self.findFeatureClassIndexFor(listResults[i]))
                      return listResults[i];
                }
            });
    };
    self.findFeatureClassIndexFor = function(geolocation){
      var featureClassNameList = geolocation.fclName.split(',');
      return featureClassNameList.indexOf("city");
    };
  }]);
{% endhighlight %}


##Solution elected

Opencage service

{% highlight js %}
reverseGeocodeModule.service('OpenCageService', [ '$http','GeoAPIConstants',
  function($http,GeoAPIConstants){
    var self = this;
    var urls = {};
    urls.geocode = "https://api.opencagedata.com/geocode/v1/json?q={1},{0}&pretty=1&key={2}";
    self.FindCityGeoCodeReverse = function(lng, lat){
      if(lng>0)
        lng='+'+lng;
      if(lat>0)
        lat='+'+lat;
      var q = $http.get(urls.geocode.format(lng,lat,GeoAPIConstants.openCage));
        return q.then(function(r){
                    return r.data.results[0].components;
        });
      };
  }]);

{% endhighlight %}
<!---
but the analysis of the results were quite disapoiting

-->
##Next experiments

The chosen API is running in beta version, so considered it risky. 
In order to mitigate it, the next step would be try the Twofishes solution, which opencage uses, to evaluate it as an alternative.


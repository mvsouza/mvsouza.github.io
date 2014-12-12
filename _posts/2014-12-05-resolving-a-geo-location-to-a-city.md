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

Then I develop a service that would use all those APIs.

To configure the service I've added constant to the angular module as follow. 

{% highlight js %}

geocodeReverseModule.constant('GeoAPIConstants', {
    mapBoxId: 'xxxxxx',
    geonameId: 'xxxxxx',
    openCage: 'xxxxxx'
  });

{% endhighlight %}

but the analysis of the results were quite disapoiting

##Solution elected

##Next experiment





---
layout: post
title: "Encontrando geo-localização de uma cidade"
modified: 2014-12-12 17:04:28 -0200
tags: [geocode, city, web-api, foursquare, twofishes, geonames, openstreetmap, opencage]
image:
  feature: 1280px-De_Merian_Sueviae_229.jpg
  credit: Wikipedia
  creditlink: wikipedia.org/
comments: true
share: true
---

Semana passada eu estava procurando uma forma de encontrar a cidade a partir de uma latitude e longitude.
Então aqui esta o que eu aprendi.


##Circunstâncias 

NA realidade eu e meu time tropeamos nesse problema pois estamos utilizando os locais da API do Foursquare, que nem sempre prove essa informação, e quando prove pode estar incorreta.
Então eu me debati com algumas soluções não satisfatórias, entre as quais testei as APIs do Geonames, Onpenstreemap e Mapbpx.
Finalmente encontrai o serviço beta do Opencage, que utiliza o Towfishes para reverter o geocode.

Eu estou atualmente usando o mapa do Mapbox map para mostrar os locais do Foursquare, e a API do Geoname para fazer o auto complete do mome cidades no nosso formulário de busca.
Não deveria ser nada difícil, se não fosse pelo fato de não podermos usar a API do Google, pois a seus termos de uso obrigam o uso do seu mapa.

##Desenvolvendo o acesso às APIs

O senário ideal seria utilizar a API do Geoname, pois o serviço é gratuito e nós já estamos usando, então os nos das cidades seriam similares aos utilizados na pesquisa de locais.

Como já havia experimentado antes, os seus resultados não seguem um padrão ao certo, mas testei novamente para ter certeza.

Como alternativa escolhi testar as APIs do Mapbox, na qual já temos conta, e Openstreetmap, que não necessita de conta.

No intuito de desencolver o teste para as APIs, programei um Webapp com Angular utilizando um template do Yeoman.

##Implementação

Então eu desenvolvi um serviço que utilizaria todas essa APIs.

Para configurar o serviço, adicionei uma constante para o módulo angular como segue added. 

{% highlight js %}
reverseGeocodeModule.constant('GeoAPIConstants', {
    mapBoxId: 'xxxxxx',
    geonameId: 'xxxxxx',
    openCage: 'xxxxxx'
  });
{% endhighlight %}

Quando desenvolvi o serviço, usei essas constantes para identificar as configurações de ambiente, então não é preciso ficar procurando per todos arquivos para alterar minhas conde acesso.   

Veja o serviços.

###Mapbox

A WEB API do Mapbox tem [essa chamada para reverter o geocode](http://api.tiles.mapbox.com/v3/examples.map-zr0njcqy/geocode/-73.989,40.733.json).


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


##Solução escolhida

Opencage

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

##Próximos passos 

A API escolhida esta rodando em versão beta, então considere esse risco. 
Para mitigar esse risco, o próximo passo seria testar a solução Twofishes, que opencage utiliza, para avalia-la como alternativa.
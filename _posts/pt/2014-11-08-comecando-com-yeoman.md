---
layout: post
title: "Começando com Yeoman"
modified: 2014-11-08 23:13:01 -0200
tags: [Yeoman, Jumpstart, boilerplate code, bower, yo, npm]
image:
feature: article-2321142-19AE06ED000005DC-80_964x641.jpg
credit: Dailymail
creditlink: http://www.dailymail.co.uk/
comments: true
share: true
---

Neste jump start vou mostrar como criar diretivas do Angular usando Yeoman.

Mas antes da parte boa, deixe-me introduzir brevemente o Yeoman, ou apenas pule para [parte boa](#letsgetdowntoit).

##What'a hell?

<p style="text-align:center;">
	<img style="height:" src="{{ site.url }}/images/yeoman-005.ef68.png"/>
</p>

Você pode não saber sobre a existência do Yoeman, como eu não conhecia. Nesse caso você deve estar se perguntando "Que m#$%# é essa?".
Yeoman é uma ferramente de scaffolding, que ajuda a desenvolvedores a começar seus projetos, especialmente o tipo web. Ele gera código ordinário, incluindo referências de pacotes bower e npm e scripts de task runners como Grunt e Gulp.  

##E o queco?

Na realidade é uma solução bem elegante, pois você pode facilmente configurar um projeto com toda uma estrutura, sem ter que ficar copiando código de outros projetos ou reescrever a mesma balela de sempre. 

<p style="text-align:center;">
	<img alt="Copy ain't funny" src="{{ site.url }}/images/Copying_test-331x285.jpg"/>
</p>

Dessa forma aumenta a sua produtividade e, se usada da forma correta, a qualidade do software ao adicionar ferramentas que você deixaria para traz por "atrasar" o "progresso" do projeto.

<p style="text-align:center;">
	<video style="width: 275px;" alt="Ain't got time for that" src="{{ site.url }}/images/aintgottimeforthat.webm" autoplay="autoplay" loop="loop"> 
		Seu browser não implementa html5 video. 
	</video>
</p>

Já contém uma coleção de geradores, que cobrem uma boa variedade de soluções. Cada qual requer algumas tarefas usuais ligados ao seu proposito, como testes automatizados, build, watch (livereload), e dependências em comum, como AngularJS, Bootstrap.

No intuito de cobrir essas necessidades, pode gerar referencias para pacotes bower e npm e arquivos Grunt ou Gult para rodar tarefas.

<!-- more -->

<span name="letsgetdowntoit"></span>

##\#LetsGetDownToIt

Precisamos de algumas coisas primeiro:

* Instale [NPM](https://www.npmjs.org/), [nodejs](http://nodejs.org/) package manager;
* E depois o próprio Yeoman.

{% highlight bash %}
npm install -g yo
{% endhighlight %}

<p alt="Ain't got time for that" style="text-align:center;">
	<video style="width: 275px;" src="{{ site.url }}/images/lonely_island_michael_bolton_jack_sparrow_back_to_.webm" autoplay="autoplay" loop="loop"> 
		Seu browser não implementa html5 video. 
	</video>
</p>

Agora estamos prontos para começar! Precisamos baixar o gerador do Yeoman para diretiva de Angular.

Você pode encontrar geradores pesquisando no npm por por pacotes com o prefixo "generator", dessa forma:

{% highlight bash %}
npm search generator OQueVocêEstaPesquisando
{% endhighlight %}

Nessa caso em especifico, vamos precisar procurar a diretiva do angular, então pesquisamos dessa forma:

{% highlight bash %}
npm search generator directive
{% endhighlight %}

Com o nome do pacote em mãos nós instalamos ele.

{% highlight bash %}
npm install generator-angular-directive -g
{% endhighlight %}

Os pacotes npm com o prefixo "generator-" nomeiam templates do yo. Para rodar o gerador recentemente adicionado, nós apenas retiramos o prefixo e passamos como argumento para o Yeoman. Antes disso, garanta que já esta na pasta do projeto.

{% highlight bash %}
mkdir ng-yomanDirective
cd ng-yomanDirective
yo angular-directive
{% endhighlight %}

Agora que a magica acontece! O Yeoman irá perguntar algumas configurações para gerar de forma mais conveniente o projeto.

Esse template irá o nome que você quer dar para diretiva e o sue nome no github.

Então irá criar a solução com:
* Uma configuração para, rodar os teste e o servidor em em live mode;
* Configuração para Testes automatizados com karma e jasmine;
* configuração para integração continua usando Travis.

Essas são as coisas que você precisa para começar a desenvolver.

Com a solução preparada, rode as seguintes linhas para instalar as dependência:

{% highlight bash %}
npm install -g gulp
npm install -g bower
npm install
bower install
{% endhighlight %}

Para rodar o live reload demo rode:

{% highlight bash %}
gulp serve
{% endhighlight %}

E para desenvolver usando TDD, procurando sempre se manter no verde, rode:

{% highlight bash %}
gulp test  
{% endhighlight %}


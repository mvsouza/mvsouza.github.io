---
layout: post
title: "Yeoman jumpstart"
modified: 2014-11-08 23:13:01 -0200
tags: [Yeoman, Jumpstart, boilerplate code, bower, yo, npm]
image:
  feature: article-2321142-19AE06ED000005DC-80_964x641.jpg
  credit: Dailymail
  creditlink: http://www.dailymail.co.uk/
comments: true
share: true
---

In this jump start we gonna learn to create a angular directive with Yeoman

But before the good part, let me briefly introduce to you Yeoman, or can't handle yourself just skip to the [good part](#letsgetdowntoit).

##What'a hell?

<p style="text-align:center;">
	<img style="height:" src="{{ site.url }}/images/yeoman-005.ef68.png"/>
</p>

You may not know about the existence of Yeoman, as I didn't. So in that case you are asking yourself "What the F$%# is this?".
Yeoman is scaffolding tool that helps developers to start up their projects, especially client side kind. It generates boilerplate code, including bower and npm package references and task runner scripts grunt or gulp.  

##And? Why should I care about it?

Actually, this is pretty neat, because you can easily set up a solution with a whole structure, without having to copy your own code or from "Google". 

<p style="text-align:center;">
<img alt="Copy ain't funny" src="{{ site.url }}/images/Copying_test-331x285.jpg"/>
</p>
Therefore, it increases your productivity and, if use it the right way, software quality, by adding and configure tools that you would may leave behind, because they "delay" your "progress".

<p style="text-align:center;">
	<video style="width: 275px;" alt="Ain't got time for that" src="{{ site.url }}/images/aintgottimeforthat.webm" autoplay="autoplay" loop="loop"> 
   Your browser does not implement html5 video. 
	</video>
</p>

It has already set of generators, that cover a good variety of solutions. Each one requires some usual tasks for its purpose, like automated tests, build, watch (livereload), and in common projects dependencies, as AngularJS, Bootstrap.

In order to cover these needs, it may generate bower and npm package references and Grunt or Gult files for running tasks.

<!-- more -->

<span name="letsgetdowntoit"></span>

##\#LetsGetDownToIt

We need some stuff fist:

* Install [NPM](https://www.npmjs.org/), [nodejs](http://nodejs.org/) package manager
* And them Yeoman itself, running the following command:

{% highlight bash %}
npm install -g yo
{% endhighlight %}

<p alt="Ain't got time for that" style="text-align:center;">
	<video style="width: 275px;" src="{{ site.url }}/images/lonely_island_michael_bolton_jack_sparrow_back_to_.webm" autoplay="autoplay" loop="loop"> 
   Your browser does not implement html5 video. 
	</video>
</p>

Now that we are good to go, we need to download the angular directives generator for Yeoman.

You can find generators by searching in npm by packages with the prefix "generator", like that:

{% highlight bash %}
npm serach generator WhaterverYouLike
{% endhighlight %}

In this case we will need the angular directive, so we like this:

{% highlight bash %}
npm serach generator directive
{% endhighlight %}

With the package name in hand we install it.

{% highlight bash %}
npm install generator-angular-directive -g
{% endhighlight %}

The npm packages with "generator-" prefix stands for yo templates. To run the recently added generator, we just need loose the prefix and pass it to the Yeomann generate it. Before this ensure that you are in the project folder.

{% highlight bash %}
mkdir ng-yomanDirective
cd ng-yomanDirective
yo angular-directive
{% endhighlight %}

Now that the magic happens! The Yeoman gladfully will ask some setting to generate in a more convenient way.

This template will ask you the name you wish to give for your new directive, and your github name.

And them It will create a solution with:
* A configuration to build, run test and run server for live demo;
* Automated test configuration with karma and jasmine;
* Travis configuration for continuous integration.

These are the things you need to just start developing.

With the solution set run the following lines to install all dependencies:

{% highlight bash %}
npm install -g gulp
npm install -g bower
npm install
bower install
{% endhighlight %}

For run the live reload demo run:

{% highlight bash %}
gulp serve
{% endhighlight %}

And to develop using TDD, looking forward to maintain your bar green, run:

{% highlight bash %}
gulp test  
{% endhighlight %}


---
layout: post
title: "Yeoman jumpstart"
modified: 2014-11-08 23:13:01 -0200
tags: [Yeoman, Jumpstart, boilerplate code, bower, yo, npm]
image:
  feature: article-2321142-19AE06ED000005DC-80_964x641.jpg
  credit: Dailymail
  creditlink: http://www.dailymail.co.uk/
comments: 
share: 
---
Before the good part, let me briefly introduce to you Yeoman, or just skip to the [good part](#letsgetdowntoit).

##What'a hell?

<p style="text-align:center;">
	<img style="height:" src="{{ site.url }}/images/yeoman-005.ef68.png"/>
</p>

You may not know about the existence of Yeoman, as I didn't. So in that case you are asking yourself "What the F$%# is this?".
Yeoman is scaffolding tool that helps developers to start up their projects, especially client side kind. It generates boilerplate code, including bower and npm package references and task runner scripts grunt or gulp.  

##And? Why should I care about it?

Actually, this is pretty neat, because you can easily set up a project with a whole structure, without having to copy your own code or from others. 

<p style="text-align:center;">
<img alt="Copy ain't funny" src="{{ site.url }}/images/Copying_test-331x285.jpg"/>
</p>
There fore, it increases your productivity and, if use it the right way, software quality, by adding tools that by yourself wouldn't be able to set in a proper time.

<p style="text-align:center;">
	<video  alt="Ain't got time for that" src="{{ site.url }}/images/aintgottimeforthat.webm" autoplay="autoplay" loop="loop"> 
   Your browser does not implement html5 video. 
	</video>
</p>

It has already set of generators, that cover a good variety of modern webapp projects. Each one requires some usual tasks for its purpose, like automated tests, build, watch (livereload), and in common projects dependencies, as AngularJS, Bootstrap.

In order to cover these needs, it may generate bower and npm package references and Grunt or Gult files for running tasks.

<span name="letsgetdowntoit"></span>

##\#LetsGetDownToIt

But we need some stuff fist:

* Install [NPM](https://www.npmjs.org/), [nodejs](http://nodejs.org/) package manager
* And them Yeoman itself.

{% highlight yaml %}
npm install -g yo
{% endhighlight %}

<p alt="Ain't got time for that" style="text-align:center;">
	<video  src="{{ site.url }}/images/lonely_island_michael_bolton_jack_sparrow_back_to_.webm" autoplay="autoplay" loop="loop"> 
   Your browser does not implement html5 video. 
	</video>
</p>

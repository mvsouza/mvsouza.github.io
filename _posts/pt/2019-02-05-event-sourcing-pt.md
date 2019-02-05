---
layout: post
title: "Event Sourcing"
modified: 2019-02-05 10:32:22 +0000
tags: [eventsource,eventdriven,DDD]
image:
  video: MichaelMurphy.webm
  credit: Perceptual Art for the video and Michael Murphy for the Art 
  creditlink: https://vimeo.com/266241166
comments: true
share: true
---
  
I know that you might be tired of reading/hearing about it, and there is enough material on it out there. Still, there are many inconsistencies and misconceptions that might make you fuzzy. So I'll show you what I see as being the basics and give you good references. If it makes you curious enough, soon I'll be posting some samples.  
  
### Concept  
  
Erick Evans, on his book about DDD, raises an interesting point about the object's life cycle and reconstituting stored objects when writing about factories:  
  
>At some point, most objects get stored in databases or transmitted through a network, and few current database technologies retain the object character of their contents. Most transmission methods **flatten an object** into an even more limited presentation. Therefore, retrieval requires a potentially complex process of reassembling the parts into a live object.  
>-- <cite>Eric Evans</cite>  
  
He is explaining the importance of factories (as ORMs) to recreate objects as they were before being persisted to the database. He argues that there is a great responsibility for these objects when they reconstitute the previous state of a disposed object as they once were.  
  
Although his idea of object's life cycle could be considered already **flatten** on an event-driven perspective. So we could say *Most structural data models **flatten objects** into an even more limited presentation.* Due to understanding it better, we should discuss what it means. Consider reading Martin Fowlers[article](https://martinfowler.com/articles/201701-event-driven.html) about the subject, where he explains his view about event source (ES):  
  
>The core idea of event sourcing is that whenever we make a change to the state of a system, we record that state change as an event, and we can confidently rebuild the system state by reprocessing the events at any time in the future. The event store becomes the principal source of truth, and the system state is purely derived from it. For programmers, the best example of this is a version control system. The log of all the commits is the event store and the working copy of the source tree is the system state.  
> -- <cite>Martin Fowler</cite>  
  
In addition to Erick`s view, ES expands the immutability, only covered by Value Objects on DDD, to whole application state, like a shadow. We only **append** facts to the repository. In spite of changing and deleting objects, we create new events that, when applied, remove or change them from the current state.  
  
### Aplication  
  
As good as it sounds, of course, you might not be already pumped to use it. I've just described what it is, not why. Why should you care? After all, if you wanna fix something without nails, a hammer is useless.  
  
I've questioned myself that years ago. To answer I had to associate with other concepts first, like distributed computing, DDD, functional programming. Now, I have a view of my own, and I hope to help to build yours.  
  
One of its characteristics is traceability/auditability. Natively, you got the ability to trace all domain changes and easily understand how the application is behaving. Even more, you could easily add user information and audite user changes.  
  
Another important feature it provides is an easy reconciliation. So, when things go south between distributed systems, one can simply ask for what happened to others on a period then process all lost messages.  
  
For these reasons, ES should solve many problems like conflict management and desynchronization on microservice applications that shares business flows and IoT/embedded systems that might work off-line.

There is plenty of real-world applications that would leverage this pattern, like:  
  
- Shipment tracker  
- IoT systems in general  
- Version control systems  
- Banking transactions  
  
### Conclusion  
  
To conclude the pros/cons, I will let Greg Young, who has made the concept popular, anwser that:  
  
>#### **Pros**  
>Single Event Centric Model  
>Simplified/Better Testing  
>Conflict Management  
>
>#### **Cons**  
>Harder to sell to an organization  
>Less known tools/technologies (though you can implement the Event Store in a RDBMS which kind of mitigates this)  
>Very difficult to migrate a legacy app to  
>--<cite>[Greg Young](http://codebetter.com/gregyoung/2010/02/20/why-use-event-sourcing/)</cite>   
  
### Next steps  
  

I've been working with C# for a while now, so I will be posting some sample soon. But keep in mind that, as Vaught Venom wrote in his book *Implementing Domain Driven Design*, "ES is inherently functional in nature", and its use on this paradigm would "potentially lead to more concise code that performs optimally".
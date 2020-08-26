# <img src="./public/favicon.ico" alt="Bee Icon" width="55" align="center"> Honey — A Rails app for managing your Hive

>I hope you have as much fun looking through and playing around with the program as I had putting it together!
>
>-Jae

## Table of contents

* [Demo Gifs and Screenshots](#demo-gifs-and-screenshots)
* [Seeds](#seeds)
* [Initial Thoughts and Decisions](#initial-thoughts-and-decisions)
  * [Models](#models)
    * [Limitations of My Approach](#limitations-of-my-approach)
  * ["Overruled" and "% Accepted"](#overruled-and--accepted)
* [Features](#features)
* [Final Thoughts](#final-thoughts)

## Demo Gifs and Screenshots

* Index Page

![index gif][demo_index]

* Show Page

![show gif][demo_show]

* Worker Bee info card and graph

![show top][show_top]

* Table - regular view

![table reg][show_bot_1]

* Table - enhanced view

![table enh][show_bot_2]

* Index Page - screenshot

![index ss][index_page]

## Seeds

You can apply a couple of settings for the seeds to be generated.

* `num_combs` sets the number of different Combs in your Hive. Currently set to 12.
* `pop_min` and `pop_max` sets the range for how many WorkersBees will be randomly generated for each Comb. Currently set to (9..15). So you'll get about 144 bees in your Hive.
* 15 "appointments" are generated for each WorkerBee (appointments will be explained later).

The seeds are random but follows the guidelines given in the instructions.

* `pollen_globs`
  * Measured about once weekly
  * range: (5.0..17.9)
  * increment: 0.1
* `nectar`
  * Given 2 to 3 times a week
  * increment: 100
  * is 0 7.75% of the time
  * matches the currently active `advisement` amount 72.5% of the time
  * is random within range: (200..20000) 20% of the time
* `advisement`
  * Given once about every 2 weeks
  * range: (200..20000)
  * increment: 100
* `sweet_spot`
  * range: (10.0..15.0)
  * increment: 0.1

However, the correlation between some of the data are not simulated. Such as:

* “There is a strong correlation between Nectar intake and PollenGlobs collected.”
* “If a WorkerBee's PollenGlobs drop below a particular Comb's SweetSpot, an Advisement will likely increase their Nectar allowance.”

## Initial Thoughts and Decisions

### Models

#### Nectar, PollenGlob, and Advisement

My first thought was to create separate Models for each of Nectar, PollenGlob, and Advisement because Advisement seemed complex enough for it's own table. However, I eventually decided to use a single Model called `Appointment` to keep track of them all. The main reason was how the data was ultimately to be presented as shown in the example row structure — all sharing one table and ordered by date.

`Appointment`s would have the following attributes:

* `worker_bee_id`
* `date`
* `pollen_globs`
* `nectar`
* `advisement`
* `adv_accepted`, which is `nil` when there is no `advisement`. It keeps track of whether the `advisement` was "Accepted" or "Overruled". (To be discussed more later)

#### WorkerBee and Comb

Instructions describe a "unique_id" for each WorkerBee for each Comb they have been in or are currently active in (i.e., 123-C5, 123-C2). When I first considered Models for `WorkerBee` and `Comb`, I wasn't sure how I would record this. I considered a Model for `CombMembership` to join the `WorkerBee` and `Comb` Models. However, for the initial implementation, I decided to stick to the simple "belongs_to/has_many" association between `WorkerBee` and `Comb`.

#### Limitations of My Approach

Some notes about the limitations of my approach:

* This way of modeling the data assumes that every `pollen_globs` measurement and `advisement` is given on a `date` that `nectar` is given. This is how the data looks in the example given, so I decided it was acceptable.
* A `WorkerBee`'s  comb affiliation can be updated, however, the data of its past comb affiliations are lost.

### "Overruled" and "% Accepted"

In my current understanding, an Advisement being "Accepted" or "Overruled" is different from the concept of "Accepted" or "Not Accepted" that exists for every nectar allowance for the calculation of "% Accepted". I made some assumptions about these concepts to complete the project.

* Advisement "accepted" vs "overruled" is a different concept from instances of Nectar allowances "accepting" vs "not accepting" the currently active Advisement amount.
* Advisements can be "overruled" only on rows of `Appointment`s where the `advisement` column is not `nil`. This is the `adv_accepted` column of the `Appointment` Model, and this is what is updated via the "Edit Advisement" form on the table of the WorkerBee show page.

I did this because I assumed that you shouldn't be able to update a Nectar allowance amount or the Advisement amount of a date long past.

#### Used JavaScript, not ActiveSupport::Concern

Ultimately, I decided to calculate this in the frontend with JavaScript since the relevant variables were already needed in the frontend for the graph. I did not utilize an ActiveSupport Concern, but learned more about the concept during the research and look forward to implementing that approach in the future.

## Features

* Thorough Model validations for `Appointment` attributes closely following the instructions describing the data.
* In addition to the graph and table, the `WorkerBee` Show Page displays useful performance metrics of WorkerBees and presents them in a way that is easy to be understood even at a glance (color coded).
* Prevents N+1 queries using ActiveRecord queries with `.joins` and `.includes`
  * Index Page shows the most recent `Appointment` date for each WorkerBee to show who has been recently active.
  * Show Page shows the WorkerBee's performance relative to Comb averages as well as Hive averages.
* Responsive interface with toggling table view modes and "update-in-place" forms using JavaScript on top of Rails.

## Final Thoughts

It was my first time with Highcharts, but as you mentioned, the documentation was awesome and the examples were great for beginners. It seems like it's full of features, and I'm excited to have just scratched the surface of it. I have also been learning D3.js, but this seems like a much easier way to play around and learn.

It was also my first time with Slim template or even an indented way to write HTML. It was so much more enjoyable to work with than erb. Thank you for the introduction.

Working on this project and learning with it has gotten me even more excited for the prospect of working at Dosis. Hope you enjoy my program, and I look forward to hearing from you soon.

-[Jaehyuk Lee](mailto:jhlumd@gmail.com)

[favicon]: ./public/favicon.ico "Bee"
[demo_index]: ./app/assets/images/demo_index.gif "Index page demo gif"
[demo_show]: ./app/assets/images/demo_show.gif "Show page demo gif"
[show_top]: ./app/assets/images/ss_show_top.png "Worker Bee info card and graph"
[show_bot_1]: ./app/assets/images/ss_show_bot_1.png "Table - regular view"
[show_bot_2]: ./app/assets/images/ss_show_bot_2.png "Table - enhanced view"
[index_page]: ./app/assets/images/ss_index.png "Index page - screenshot"

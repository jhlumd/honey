# <img src="./public/favicon.ico" alt="Bee Icon" width="55" align="center"> Honey — A Rails app for managing your Hive

I hope you have as much fun looking through and playing around with the program as I had putting it together!

-Jae

## Table of contents

* [Demo Gifs and Screenshots](#demo-gifs-and-screenshots)
* [Initial Thoughts and Decisions](#initial-thoughts-and-decisions)
  * [Models](#models)
  * [Settings for Seeds](#settings-for-seeds)
  * ["% Accepted"](#-accepted)

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

## Initial Thoughts and Decisions

### Models

#### Nectar, PollenGlob, and Advisement

My first thought was to create separate Models for each of Nectar, PollenGlob, and Advisement because Advisement seemed complex enough for it's own table. However, I eventually decided to use a single Model called `Appointment` to keep track of them all. The main reason was how the data was ultimately to be presented as shown in the instruction's example — all sharing one table and ordered by date.

`Appointment`s would have the following attributes:

* `worker_bee_id`
* `date`
* `pollen_globs`
* `nectar`
* `advisement`
* `adv_accepted` is `nil` when there is no `advisement`. It keeps track of whether the `advisement` was "Accepted" or "Overruled". (To be discussed more later)

Some notes about the limitations of my approach:

* I noticed that this way of organizing the data assumes that every `pollen_globs` measurement and `advisement` is given on a `date` that `nectar` is given. This is how the data looks in the example given, so I decided this approach was acceptable.
* In my understanding, `adv_accepted` is different from "Accepted" or "Not Accepted" that exists for every `nectar` allowance for calculation of "% Accepted" later.
* Instructions mention a "unique_id" for each WorkerBee for each Comb they have been in or are currently active within. My current implemntation of `Appointment` keeps track of the associated WorkerBee but not the Comb at the time of the `Appointment`. I considered a joins table for Comb "membership" of WorkerBees over time, but have not implemented this.

#### WorkerBee and Comb

When I first considered Models for `WorkerBee` and `Comb`, I wasn't sure how I would record `unique_id`'s changes over time for each `WorkerBee`. As mentioned above, I considered a Model for `CombMembership` to join `WorkerBee` and `Comb` over time. However, for the initial implementation, I decided to stick to the simple "belongs_to/has_many" association between `WorkerBee` and `Comb`.

### Settings for Seeds

You can apply a couple of settings for the seeds to be generated.

* `num_combs`: sets the number of different Combs in your Hive. Currently set to 12.
* `pop_min` and `pop_max`: sets range for the randomly generated number of WorkerBees to belong to each Comb. Currently set to (9..15). So you'll get about 144 bees.

The seeds are random by follows the ranges/parameters given in the instructions. However, the correlation between some of the data are not simulated. Such as,

* “There is a strong correlation between Nectar intake and PollenGlobs collected.”
* “If a WorkerBee's PollenGlobs drop below a particular Comb's SweetSpot, an Advisement will likely increase their Nectar allowance.”

### "% Accepted"

I made several assumptions regarding the instructions I didn't completely understand to complete the project.

* Advisement "accepted" vs "overruled" is a different concept from instances of Nectar allowances "accepting" vs "not accepting" the currently active Advisement amount.
  * Advisements can be "overrulled" on rows of `Appointment`s where the `advisement` column is not `nil`. This is the `adv_accepted` column of the `Appointment` Model, and this is what is updated via the "Edit Advisement" form on the regular view mode of the table on the WorkerBee show page.
  * I did this because I assumed that you shouldn't be able to update a Nectar allowance amount or the Advisement amount of a date long past.
  * "% Accepted" does not have a a column dedicated to it in the DB. It is calculated using the `nectar` and `advisement` values.

[favicon]: ./public/favicon.ico "Bee"
[demo_index]: ./app/assets/images/demo_index.gif "Index page demo gif"
[demo_show]: ./app/assets/images/demo_show.gif "Show page demo gif"
[show_top]: ./app/assets/images/ss_show_top.png "Worker Bee info card and graph"
[show_bot_1]: ./app/assets/images/ss_show_bot_1.png "Table - regular view"
[show_bot_2]: ./app/assets/images/ss_show_bot_2.png "Table - enhanced view"
[index_page]: ./app/assets/images/ss_index.png "Index page - screenshot"

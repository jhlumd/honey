# Dev Notes

1. Considering Models for WorkerBee (belongs_to :comb) and Comb (has_many :worker-bees). But unsure yet how I will display changing ids over time on the table for the bee when they change combs (i.e., 123-C1, 123-C4).

2. Initially considered separate Models for PollenGlob, Nectar, and Advisement (all belongs_to :worker_bee), but now I'm thinking a single Model for all 3 with a column for type". Bbetter approach? I was thinking that having all 3 on one table will help me when I have to organize by date later for the table. Otherwise, it's not clear to me yet how I will iterate through all PollenGlobs, Nectars, and Advisements for each bee and organize by date (Am I overthinking/confused here?)

3. One of the advice given in the instructions say "Don't mess with timestamps for date. Don't hack around with created_at or anything, use a single-responsibility column." -- What does this mean?. Should I be thinking about a separate date column for organizing the table?

4. Looking at the example row structure/ example table, still not sure how "% Accepted" is calculated. For the second row from the bottom, even though the active Advisement is 600 units and 600 units is given, % Accepted is 50% and not 100% so this confuses me.

5. Regarding #2 above, instead of having a column for type, it's probably better to have columns just like the example row structure/table.

6. Regarding #1, considering a column `unique_id` or `history` to contain an array of all of a WorkerBee's past/cur comb_id.

7. Advisement being Accepted / Overruled with "Edit Advisement" button is different from Nectar given amount and active Advisement amount not matching?

8. Do I need a column in Appointments for Advisement_Accepted? What does this accomplish? I can just look at if the Nectar given amount matches the active Advisement amount.

9. Once an "Edit Advisement" form updates an Advisement, all the % Accepted columns above and up until the next Advisement needs to update.

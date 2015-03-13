We implemented matrix factorization using the Alternating Least Squares algorithm.
The number of latent factors we used was 20 (as specified in the project description),
and our value of lambda was [******] because [******]. Our stopping criterion was based
on the change in U from step to step. As it got closer to 0, we stopped.
Our equations for each step of U and V were as follows:
[******]
We implemented this in Matlab. With the resulting U and V vectors we applied Matlab's
built in SVD function and chose the first two columns of the result to get the best
projection of our model to two dimensions. Then, we plotted interesting results of our
model that we found.

We would expect movies from the same series to be similar, and therefore have similar
weights in our model. So, we plot the values of V for a few series:
[******]

We also want to check that our projection from 20 dimensions to 2 dimensions did not
lose too much information. So, we find the difference in normalized scores between
the two different models, and look at the difference. The average difference is
-2.8276e-14, very close to 0. The standard deviation of the difference is 1.4268. Since
it is centered, this indicates a random error and we can conclude that the 2 dimensional
model is fairly accurate.


Now, we would like to see if the dimensions mean something that we can interpret. So,
we plot the means of each genre:
[******]

The genres are labeled as follows:
1 : unknown
2 : Action
3 : Adventure
4 : Animation
5 : Children’s
6 : Comedy
7 : Crime
8 : Documentary
9 : Drama
10: Fantasy
11: Film-Noir
12: Horror
13: Musical
14: Mystery
15: Romance
16: Sci-Fi
17: Thriller
18: War
19: Western

So, we see that these two dimensions can be interpreted as having some meaning;
we see that the first dimension can be seen as representing [******], while the
second dimension can be seen as representing [******].

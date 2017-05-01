### 2. Close vs. distant friends

In the basic "six degrees of separation" question, one asks whether most pairs of people in the world are connected by a path of at most six edges in the social network, where an edge joins any two people who know each other on a first-name basis.
Now let's consider a variation on this question. For each person in the world, we ask them to rank the 30 people they know best, in descending order of how well they know them. (Let's suppose for purposes of this question that each person is able to think of 30 people to list.) We then construct two different social networks:
  (a) The "close-friend" network: from each person we create a directed edge only to their ten closest friends on the list.

  (b) The "distant-friend" network: from each person we create a directed edge only to the ten people listed in positions 21 through 30 on their list.

Let's think about how the small-world phenomenon might differ in these two networks. In particular, let C be the average number of people that a person can reach in six steps in the close-friend network, and let D be the average number of people that a person can reach in six steps in the distant-friend network (taking the average over all people in the world).

When researchers have done empirical studies to compare these two types of networks (the exact details often differ from one study to another), they tend to find that one of C or D is consistently larger than the other. Which of the two quantities, C or D, do you expect to be larger? Give a brief explanation for your answer.


	This question has to deal with the psychology of groups.
	How do people interact with one another?

	What is embedded in the close-friend network?

	Could we think about this problem via a directed graph?
		That would be the only way to follow the path and meeting new people.

	If this were a directed graph within a close-friend network, there will be less new paths to follow in which there will always be new people. 
	


Note: This problem was taken from Chapter 20 of [Networks, Crowds, and Markets](https://www.cs.cornell.edu/home/kleinber/networks-book/).
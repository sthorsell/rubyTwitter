1. Introduction
2. Devise and OAuth
3. Twitter API
4. Meta Programming
5. Future

1. Introduction
This application allows the retrieving of a tweets for a specific account for which the user must log in to. First create an account by clicking the sign up link. Then click link with Twitter and log in with Twitter credentials to approve the retrieval of your tweets. They will then be display on the home page. You can click link with twitter at any time to link a different account, but once you do the previous Twitter account tweets will be erased.

2. Devise and OAuth
The devise gem is used to keep track of user accounts separate from Twitter. This means that a user has to register to link their Twitter account. There is a one to one relationship with devise accounts to Twitter accounts. Recent versions of devise allow the integrating of OAuth gems, so I included the oauth-twitter gem which allows easy generation of access tokens that authenticate their account to my application with the user having to reveal their password. An important note is that the Consumer Secret and Consumer Key are stored in the environment that the application is running on. This makes the application less portable, but doesn't expose my API keys. 

3. Twitter API
Twitter has a RESTful API that is fairly straightforward to use. The call that I utilize gets a specific user's timeline who has already authenticated to the application. When the home page is reloaded, it gets new tweets from the user as well. If a user has existing tweets already I get the ID of the most recent one and only retrieve tweets newer than that. This will save loading the same tweets over and over. If I didn't do this it could be possible to just get the data live from Twitter and not store the tweets. 

4. Meta Programming
	Meta Programming is used all over in rails, such as in the models with attributes. I implemented a few examples of meta programming as well. In the Tweet model I define an array of times that are one week, one month, and one year ago. Instead of making three methods to retrieve tweets in a specific, I am able to loop through the array and dynamically add these methods. It would be easy to add other times to the array and expand it.
	In the home helper I define a module that allows the creation of a method to generate a consumer for a specific OAuth service. The user passes in the provider name followed by the api for that provider. This can be made into an array and multiple consumer methods can be created at once. I implement this in the home controller to generate my twitter consumer.
	In the call back controller for OAuth I use meta programming by lazily defining variables to hold the token and secret. Instead of having to create a class specifying variable names I am able to use dot notation and Ruby will automatically create these variables and keep track of them.
	Meta programming is incredibly powerful and used a lot in Rails and Ruby. The ability to reference a class using self and dynamically add methods at run time is an awesome feature.
	
5. Future
	This application has the functionality to retrieve a specific user's tweets. A consideration that I thought about implementing was allows a single devise user to keep track of multiple twitter accounts. This could be useful if a user would like to follow multiple users. Also adding the ability to follow public timelines would be helpful, so the user wouldn't have to be the owner of the timeline they want to follow. Making more use of the Twitter API is an obvious addition, such as allowing people to post tweets. Also the UI could be greatly improved, the application was intended to show the functionality that the Twitter API can provide.
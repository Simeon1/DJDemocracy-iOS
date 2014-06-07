
# API

### Song Object

```
{
	"title": "some shit"
	"artist": "some band"
	"votes": 2 // optional
}
```
***

### POST: `/upvote`
```
{
	"song":Song
}
```

##### Example:
```
{
	"song": {
		"title": "Turn Down for What",
		"artist": "DJ Snake & Lil Jon"
	}
}
```


### POST: `/downvote`
```
{
	"song":Song
}
```

##### Example:
```
{
	"song": {
		"title": "Song That Isn't Turn Down for What",
		"artist": "Someone Shitty"
	}
}
```


### POST `/sendsongs`
```
{
	"songs":[
		Song,
		Song,
		Song,
		...
	]
}
```

#### Returns: 
```
{
	"songs":[
		Song,
		...
	]
}
```

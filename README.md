wallposterb
===========

Ruby server that accepts Facebook wallposts and handles them one by one asynchronously.

Raw usage
---------

You can use wallposterb by POSTing to port 4321 with a JSON encoded array of Facebook wallposts.
This array should look like this:

```
[
    {
        "token": "token",
        "to": "me",
        "message": "hello"
    },
    {
        "token": "token",
        "to": "me",
        "message": "hello2",
        "link": "http://google.com",
        "name": "Goochel"
    }
]
```

All possible keys are:
`token, to, message, link, picture, name, caption, description, actions, place, tags, privacy, object_attachment`


PHP usage
---------

First, include the PHP bindings

```
//On nubisonline.nl
include("/home/bliss/includes/wallposterb/wallposterb.php");
//On nubisfacebook.nl
include("/home/nubisfacebook.nl/includes/wallposterb/wallposterb.php");
```

Then, you can use the make_wallpost function like this:

```
$post1 = new Post("token", "me", "hello"); 
$post2 = new Post("token", "me", "hello2");
$post2->setLink("http://google.com");
$post2->setName("Goochel");
$posts = array($post1, $post2);
make_wallpost($posts);
```

You can also call make_wallpost() with just a Post as argument.

Here is the full reference for the Post class:

```
  __construct ($token, $to, $message, $link="", $picture="", $name="", $caption="", $description="", $actions="", $place="", $tags="", $privacy="", $object_attachment="")
  
  getToken ()
  getTo ()
  getMessage ()
  getLink ()
  getPicture ()
  getName ()
  getCaption ()
  getDescription ()
  getActions ()
  getPlace ()
  getTags ()
  getPrivacy ()
  getObject_attachment ()
  
  setToken ($_token)
  setTo ($_to)
  setMessage ($_message)
  setLink ($_link)
  setPicture ($_picture)
  setName ($_name)
  setCaption ($_caption)
  setDescription ($_description)
  setActions ($_actions)
  setPlace ($_place)
  setTags ($_tags)
  setPrivacy ($_privacy)
  setObject_attachment ($_object_attachment)
```
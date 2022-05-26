# Sinatra API CRUD and Relationships

Question to ponder before we start:

>Is it better to keep all of our fetches/state in a container and pass down state and callbacks as props or to add state and fetch calls throughout the component hierarchy where necessary? Explain the benefits of your choice.

## Today's Focus

- How we make decisions about how to structure data from our API given the structure and needs of our react application
- considering alternatives for how to store related data in react state.
- retrieving related records via our API and persisting them to React state.
- using the options on the `to_json` method to include associated database records in API responses.


In our previous lecture, we reviewed how to handle CRUD operations by building out the following endpoints:

- `get '/dogs'`
- `post '/dogs'`
- `patch '/dogs/:id'`
- `delete '/dogs/:id'`

and for walks, we built out:

- `get '/walks'`
- `post '/walks`
- `delete '/walks/:id'`

Currently, the `post '/walks'` endpoint can associate multiple dogs with a single walk in the database, but our react client isn't tracking the relationship at all. We also want the ability to create walks for a dog from the dog detail page and to display them.

## Our Main Concerns

- We need to retrieve the dogs on a particular walk. 
- We also need to track the walks a particular dog has been on.

The decision we need to make is between 2 main options:

1. Get all related records that we want to display with every request to the API (all walks included with dogs)
2. Get only the primary records within the list view (`/dogs`) and only retrieve related records when hitting the show (detail) endpoint (`/dogs/:id`) 

### Pros of Option 1 (Getting all walks when fetching '/dogs'):

- If we have all walks with the dogs, then the state shape is consistent for all dogs (whether we have visited the show route or not)
- If we get all of the information from the fetch to `/dogs` then we don't need to have a separate endpoint for `/dogs/:id` if we don't want to have it.

### Cons of Option 1:

- If we fetch all of the related information when we hit the `/dogs` endpoint, we'll end up fetching a bunch of information that our users may not want to see on their current visit.
- Because we're fetching additional information at the `/dogs` endpoint, the endpoint will also take a bit longer to respond than if we didn't include the related information.
- At scale this will become problematic if users can accumulate 10s of thousands of data points, so we'd probably want to shift away from an approach like this eventually.
- If we're storing walks with dogs, showing an index of walks will likely require another fetch to `/walks`, which will result in duplicated data being stored in state. (Duplicated data can be a headache when mutations occur like updating or deleting a walk because it would now necessitate a change to two pieces of state that live in different places within the component hierarchy)

### Pros of Option 2 (Getting all walks when fetching '/dogs/:id')

- If we only fetch the dogs from `/dogs` and then only retrieve the walks when hitting the `/dogs/:id`
  - then our endpoint will respond more quickly.
  - our state won't include information that our users haven't yet decided that they wanted to see.

### Cons of Option 2

- If we only fetch dogs from the `/dogs` endpoint and then retrieve the walks with the dog when we hit `/dogs/:id`, then
  - we'll need to trigger an additional fetch call when we visit the `/dogs/:id` client side route.
  - the stateful logic may be more complicated.
    - we could give the detail component state for walks and store the related data there, but then we'd need to refetch every time we return to that, or a different dog show route.
  - we could keep all dogs in state within the `DogsContainer` and then store the related walks as a property within the dog. It will require extra conditional logic both to update the state of the parent upon receiving the results of a fetch from `DogDetail`. We can also add additional logic to check if the walks are already there within state before we trigger a fetch to the api to avoid refetching (this is sometimes called caching).
- Although the initial load for the list will be faster with this approach, additional fetches will be required as you move from page to page, so the app may feel slower in the long run than fetching everything up front-despite the longer initial load with that approach.

### Making the Decision

In this case, we're going to go with option 1 because it will simplify our react state logic. If our app grows a lot, and we start having performance issues, we can think about reworking our approach, but for the start it will work fine to always return the related objects as a property (walks within each dog) and it'll be much easier to work with on the react end at this point. 

When working on large applications with many components and complex data requirements, this is not an optimal solution. If you want to look into a more robust and scalable solution, you can check out:

- [React Query](https://react-query.tanstack.com/) -- ([Code](https://github.com/tannerlinsley/react-query)), ([Docs](https://react-query.tanstack.com/overview)), ([Video](https://www.youtube.com/watch?v=novnyCaa7To))
- Or if you want to learn Redux, [RTK Query](https://redux-toolkit.js.org/rtk-query/overview) is the part of redux devoted to elegantly solving this problem.

## How to include relationships within our API's JSON responses

The way we'll include these relationships with the JSON responses is by using the `include` option for the `to_json` method.

```rb
# t.string :username
# t.string :email
class User < ActiveRecord::Base
  has_many :posts
end

# t.string :title
# t.text :content
class Post < ActiveRecord::Base
  belongs_to :user

  def reading_time
    words_per_minute = 180

		words = content.split.size;
		minutes = ( words / words_per_minute ).floor
		minutes_label = minutes === 1 ? " minute" : " minutes"
		minutes > 0 ? "about #{minutes} #{minutes_label}" : "less than 1 minute"
  end
end

# t.string :content
# t.integer :user_id
# t.integer :post_id
class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  delegate :username, to: :user
end

User.first.to_json(
  only: [:username],
  include: {
    posts: {
      only: [
        :id, 
        :title
      ],
      methods: [:reading_time]
      include: {
        comments: {
          only: [:content],
          methods: [:username]
        }
      }
    }
  }
)

{
  username: "Dakota",
  posts: [
    { 
      id: 1, 
      title: "My first post", 
      reading_time: "less than 1 minute", 
      comments: [
        { 
          content: "so short!",
          username: "So meone"
        }
      ] 
    },
    { 
      id: 2, 
      title: "The second post", 
      reading_time: "about 4 minutes", 
      comments: [
        { 
          content: "love this post",
          username: "Noo ne"
        }
      ]
    },
    { 
      id: 3,
      title: "A funny post",
      reading_time: "about 3 minutes", 
      comments: [
        { 
          content: "haha",
          username: "Nob ody"
        }
      ]
    }
  ]
}
```

#### Resources

- [to_json docs](https://apidock.com/rails/ActiveRecord/Serialization/to_json)
- [Preview of Serialization in Rails](https://thoughtbot.com/blog/better-serialization-less-as-json)

### DRY serialization

Converting an object or collection of objects to JSON format is referred to as serialization. As our logic for serialization becomes more complicated, we'll want to pull it out of individual endpoints so we don't have to repeat it 3 or more times within our controller. 

> When we get to Rails in Phase 4, you'll learn another way of serializing objects/collections that involves creating separate files called serializers. For now, we'll just add a private method to our controller called `serialize` and invoke it from each endpoint.

```rb
class UsersController < ApplicationController
  get "/users" do 
    serialize(User.all)
  end

  get "/users/:id" do 
    serialize(User.find(params[:id]))
  end

  # ...

  private

  def serialize(objects)
    objects.to_json(
      only: [:username],
      include: {
        posts: {
          only: [
            :id, 
            :title
          ],
          methods: [:reading_time],
          include: {
            comments: {
              only: [:content],
              methods: [:username]
            }
          }
        }
      }
    )
  end
end
```

## Client side state updates to support CRUD

| Endpoint | CRUD Action | Server Response | State Update |
|---|---|---|---|
| `get '/dogs'` | Read (Index) | array of objects (`dogs`) | `setDogs(dogs)` |
| `get '/dogs/:id'` | Read (Show) | single object (`dog`) with associated `walks` included| `setDogs(dogs => dogs.map(d => d.id === dog.id ? dog : d))` (if we're fetching walks separately–if we're fetching all dogs and walks up front from `/dogs` then this endpoint isn't necessary) -- More commonly we might just have something like this: `setDog(dog)`| 
| `post '/dogs'` | Create | single object (`dog`) | `setDogs(dogs => dogs.concat(dog))` or `setDogs(dogs => [...dogs, dog])` |
| `patch '/dogs/:id'` | Update | single object (`dog`) | `setDogs(dogs => dogs.map(d => d.id === dog.id ? dog : d))` |
| `delete '/dogs/:id'` | Delete | single object (`dog`) | `setDogs(dogs => dogs.filter(d => d.id !== dog.id )` |

Break!

## Changes to our Demo codebase

- Look at the `DogDetail` view and examine the data requirements to show walk info.
- Update `DogsController`'s `serialize` method to include required data.
- Examine code in `DogWalksController` and discuss the discrepancy between the user input format and the dog_walks schema. 

Refer to the [README.md](./exercise/README.md) in the exercise directory for instructions on how to approach the exercise.
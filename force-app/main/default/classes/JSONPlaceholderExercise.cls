// Content-Type header is set to "application/json" directly in the JSONPlaceholder Named Credential 
public class JSONPlaceholderExercise {

    private static final String BASE_URL = 'callout:JSONPlaceholder'; // Only should be visible to class itself
    
    /**
     * Exercise 1: Implement a GET request to fetch a post by ID
     * Endpoint: /posts/{postId}
     * @param postId - The ID of the post to fetch
     * @return String - The JSON response from the API
     */
    public static String getPostById(Integer postId) {
        // TODO: Student Implementation
        // 1. Create a new HTTP request
        HttpRequest request = new HttpRequest();
        // 2. Set the endpoint URL using BASE_URL + '/posts/' + postId
        request.setEndpoint(BASE_URL + '/posts/' + postId);
        // 3. Set the HTTP method to 'GET'
        request.setMethod('GET');
        // Implementing 5 seconds request timeout, due to the known short processing time of the server, to avoid hanging the org in case of server timeout
        request.setTimeout(5000); 
        // 4. Send the request and get the response
        Http http = new Http();
        HttpResponse response = http.send(request);
        // 5. Return the response body as string
        if(response.getStatusCode() == 200){
            return response.getBody();
        }
        // Implement error handling
        throw new PostServiceException(response.getStatus());
    }
    
    /**
     * Exercise 2: Implement a POST request to create a new post
     * Endpoint: /posts
     * @param title - The title of the post
     * @param body - The body content of the post
     * @param userId - The user ID creating the post
     * @return String - The JSON response from the API
     */
    public static String createPost(String title, String body, Integer userId) {
        // TODO: Student Implementation
        // 1. Create a new HTTP request
        HttpRequest request = new HttpRequest();
        // 2. Set the endpoint URL using BASE_URL + '/posts'
        request.setEndpoint(BASE_URL + '/posts');
        // 3. Set the HTTP method to 'POST'
        request.setMethod('POST');
        // Implementing 5 seconds request timeout, due to the known short processing time of the server, to avoid hanging the org in case of server timeout
        request.setTimeout(5000); 
        // 4. Create a JSON string with the post data
        JSONPlaceholder post = new JSONPlaceholder();
        post.title = title;
        post.body = body;
        post.userId = userId;
        // 5. Set the request body
        request.setBody(JSON.serialize(post));
        // 6. Send the request and get the response
        Http http = new Http();
        HttpResponse response = http.send(request);
        // 7. Return the response body as string
        if(response.getStatusCode() == 201){
            return response.getBody();
        }
        // Implement error handling
        throw new PostServiceException(response.getStatus());
    }
    
    /**
     * Exercise 3: Implement a PUT request to update a post
     * Endpoint: /posts/{postId}
     * @param postId - The ID of the post to update
     * @param title - The new title
     * @param body - The new body content
     * @param userId - The user ID
     * @return String - The JSON response from the API
     */
    public static String updatePost(Integer postId, String title, String body, Integer userId) {
        // TODO: Student Implementation
        // 1. Create a new HTTP request
        HttpRequest request = new HttpRequest();
        // 2. Set the endpoint URL using BASE_URL + '/posts/' + postId
        request.setEndpoint(BASE_URL + '/posts/' + postId);
        // 3. Set the HTTP method to 'PUT'
        request.setMethod('PUT');
        // Implementing 5 seconds request timeout, due to the known short processing time of the server, to avoid hanging the org in case of server timeout
        request.setTimeout(5000); 
        // 4. Create a JSON string with the updated post data
        JSONPlaceholder post = new JSONPlaceholder();
        post.title = title;
        post.body = body;
        post.userId = userId;
        // 5. Set the request body
        request.setBody(JSON.serialize(post));
        // 6. Send the request and get the response
        Http http = new Http();
        HttpResponse response = http.send(request);
        // 7. Return the response body as string
        if(response.getStatusCode() == 200){
            return response.getBody();
        }
        // Implement error handling
        throw new PostServiceException(response.getStatus());
    }
    
    /**
     * Exercise 4: Implement a PATCH request to partially update a post
     * Endpoint: /posts/{postId}
     * @param postId - The ID of the post to patch
     * @param title - The new title (can be null)
     * @return String - The JSON response from the API
     */
    public static String patchPostTitle(Integer postId, String title) {
        // TODO: Student Implementation
        // 1. Create a new HTTP request
        HttpRequest request = new HttpRequest();
        // 2. Set the endpoint URL using BASE_URL + '/posts/' + postId
        request.setEndpoint(BASE_URL + '/posts/' + postId);
        // 3. Set the HTTP method to 'PATCH'
        request.setMethod('PATCH');
        // Implementing 5 seconds request timeout, due to the known short processing time of the server, to avoid hanging the org in case of server timeout
        request.setTimeout(5000); 
        // 4. Create a JSON string with only the title
        Map<String,String> post = new Map<String,String>();
        post.put('title', title); // We are only interested in updating the post's title
        // 5. Set the request body
        request.setBody(JSON.serialize(post));
        // 6. Send the request and get the response
        Http http = new Http();
        HttpResponse response = http.send(request);
        // 7. Return the response body as string
        if(response.getStatusCode() == 200){
            return response.getBody();
        }
        // Implement error handling
        throw new PostServiceException(response.getStatus());
    }
    
    /**
     * Exercise 5: Implement a DELETE request to remove a post
     * Endpoint: /posts/{postId}
     * @param postId - The ID of the post to delete
     * @return Integer - The HTTP status code from the response
     */
    public static Integer deletePost(Integer postId) {
        // TODO: Student Implementation
        // 1. Create a new HTTP request
        HttpRequest request = new HttpRequest();
        // 2. Set the endpoint URL using BASE_URL + '/posts/' + postId
        request.setEndpoint(BASE_URL + '/posts/' + postId);
        // 3. Set the HTTP method to 'DELETE'
        request.setMethod('DELETE');
        // Implementing 5 seconds request timeout, due to the known short processing time of the server, to avoid hanging the org in case of server timeout
        request.setTimeout(5000); 
        // 4. Send the request and get the response
        Http http = new Http();
        HttpResponse response = http.send(request); 
        // 5. Return the response status code
        if(response.getStatusCode() == 200){
            return response.getStatusCode();
        }
        // Implement error handling
        throw new PostServiceException(response.getStatus());
    }

    /*
    * <<<< BULK OPERATIONS >>>>
    */

    /**
     * Endpoint: /posts/{postId}
     * @param postIds - The ID of the posts to fetch
     * @return List<String> - The JSON responses from the API
     */
    public static List<String> getPostsById(List<Integer> postIds) {
        List<String> responses = new List<String>();
        for(Integer postId:postIds){
            responses.add(getPostById(postId));
        }
        return responses;
    }

    /**
     * Endpoint: /posts
     * @param posts - JSONPlaceholder posts to create
     * @return List<String> - The JSON responses from the API
     */
    public static List<String> createPosts(List<JSONPlaceholder> posts) {
        List<String> responses = new List<String>();
        for(JSONPlaceholder post:posts){
            responses.add(createPost(post.title, post.body, post.userId));
        }
        return responses;
    }

    /**
     * Endpoint: /posts/{postId}
     * @param posts - JSONPlaceholder posts to update
     * @return List<String> - The JSON responses from the API
     */
    public static List<String> updatePosts(List<JSONPlaceholder> posts) {
        List<String> responses = new List<String>();
        for(JSONPlaceholder post:posts){
            responses.add(updatePost(post.id, post.title, post.body, post.userId));
        }
        return responses;
    }

    /**
     * Endpoint: /posts/{postId}
     * @param posts - JSONPlaceholder posts to partially update
     * @return List<String> - The JSON responses from the API
     */
    public static List<String> patchPostsTitle(List<JSONPlaceholder> posts) {
        List<String> responses = new List<String>();
        for(JSONPlaceholder post:posts){
            responses.add(patchPostTitle(post.id, post.title));
        }
        return responses;
    }

    /**
     * Endpoint: /posts/{postId}
     * @param postIds - The ID of the posts to delete
     * @return List<Integer> - The HTTP status code from the responses
     */
    public static List<Integer> deletePosts(List<Integer> postIds) {
        List<Integer> statusCodes = new List<Integer>();
        for(Integer postId:postIds){
            statusCodes.add(deletePost(postId));
        }
        return statusCodes;
    }

    public class JSONPlaceholder{
        // https://jsonplaceholder.typicode.com/posts
        public Integer id;	
        public Integer userId;	
        public String title;	
        public String body;
    }

    public class PostServiceException extends Exception{}
} 
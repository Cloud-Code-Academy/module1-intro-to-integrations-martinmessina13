@IsTest
public class JSONPlaceholderExerciseTest {
    
    @IsTest
    static void testGetPostById() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new JSONPlaceholderMock(200, JSONPlaceholderMock.getSampleGetResponse()));
        
        // Act
        String response = JSONPlaceholderExercise.getPostById(1);
        
        // Assert
        Assert.isNotNull(response, 'Response should not be null');
        Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(response);
        Assert.areEqual(1, responseMap.get('id'), 'Post ID should match the request');
        Assert.areEqual('Sample Post', responseMap.get('title'), 'Post title should match the mock response');
    }
    
    @IsTest
    static void testCreatePost() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new JSONPlaceholderMock(201, JSONPlaceholderMock.getSamplePostResponse()));
        
        // Act
        String response = JSONPlaceholderExercise.createPost('New Post', 'This is a new post', 1);
        
        // Assert
        Assert.isNotNull(response, 'Response should not be null');
        Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(response);
        Assert.areEqual(101, responseMap.get('id'), 'New post should have ID 101');
        Assert.areEqual('New Post', responseMap.get('title'), 'Post title should match the request');
    }
    
    @IsTest
    static void testUpdatePost() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new JSONPlaceholderMock(200, JSONPlaceholderMock.getSamplePutResponse()));
        
        // Act
        String response = JSONPlaceholderExercise.updatePost(1, 'Updated Post', 'This is an updated post', 1);
        
        // Assert
        Assert.isNotNull(response, 'Response should not be null');
        Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(response);
        Assert.areEqual('Updated Post', responseMap.get('title'), 'Post title should be updated');
    }
    
    @IsTest
    static void testPatchPostTitle() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new JSONPlaceholderMock(200, JSONPlaceholderMock.getSamplePatchResponse()));
        
        // Act
        String response = JSONPlaceholderExercise.patchPostTitle(1, 'Updated Title');
        
        // Assert
        Assert.isNotNull(response, 'Response should not be null');
        Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(response);
        Assert.areEqual('Updated Title', responseMap.get('title'), 'Post title should be updated');
    }
    
    @IsTest
    static void testDeletePost() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new JSONPlaceholderMock(200, ''));
        
        // Act
        Integer statusCode = JSONPlaceholderExercise.deletePost(1);
        
        // Assert
        Assert.areEqual(200, statusCode, 'Delete request should return status code 200');
    }

    @IsTest
    static void testGetPostsByIds() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new JSONPlaceholderMock(200, JSONPlaceholderMock.getSampleGetResponse()));
        List<Integer> postIds = new List<Integer>{1,1,1,1,1};
        
        // Act
        List<String> responses = JSONPlaceholderExercise.getPostsById(postIds);
        
        // Assert
        for(String response:responses){
            Assert.isNotNull(response, 'Response should not be null');
            Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(response);
            Assert.areEqual(1, responseMap.get('id'), 'Post ID should match the request');
            Assert.areEqual('Sample Post', responseMap.get('title'), 'Post title should match the mock response');
        }
    }

    @IsTest
    static void testCreatePosts() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new JSONPlaceholderMock(201, JSONPlaceholderMock.getSamplePostResponse()));

        List<JSONPlaceholderExercise.JSONPlaceholder> posts = new List<JSONPlaceholderExercise.JSONPlaceholder>();

        for(Integer i = 0; i < 5; i++){
            JSONPlaceholderExercise.JSONPlaceholder post = new JSONPlaceholderExercise.JSONPlaceholder();
            post.title = 'New Post';
            post.body = 'This is a new post';
            post.userId = 1;
            posts.add(post);
        }
        
        // Act
        List<String> responses = JSONPlaceholderExercise.createPosts(posts);
        
        // Assert
        for(String response:responses){
            Assert.isNotNull(response, 'Response should not be null');
            Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(response);
            Assert.areEqual(101, responseMap.get('id'), 'New post should have ID 101');
            Assert.areEqual('New Post', responseMap.get('title'), 'Post title should match the request');
        }
    }
    
    @IsTest
    static void testUpdatePosts() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new JSONPlaceholderMock(200, JSONPlaceholderMock.getSamplePutResponse()));

        List<JSONPlaceholderExercise.JSONPlaceholder> posts = new List<JSONPlaceholderExercise.JSONPlaceholder>();

        for(Integer i = 0; i < 5; i++){
            JSONPlaceholderExercise.JSONPlaceholder post = new JSONPlaceholderExercise.JSONPlaceholder();
            post.title = 'Updated Post';
            post.body = 'This is an updated post';
            post.userId = 1;
            post.id = 1;
            posts.add(post);
        }
        
        // Act
        List<String> responses = JSONPlaceholderExercise.updatePosts(posts);

        // Assert
        for(String response:responses){
            Assert.isNotNull(response, 'Response should not be null');
            Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(response);
            Assert.areEqual('Updated Post', responseMap.get('title'), 'Post title should be updated');
        }
    }
    
    @IsTest
    static void testPatchPostsTitle() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new JSONPlaceholderMock(200, JSONPlaceholderMock.getSamplePatchResponse()));

        List<JSONPlaceholderExercise.JSONPlaceholder> posts = new List<JSONPlaceholderExercise.JSONPlaceholder>();

        for(Integer i = 0; i < 5; i++){
            JSONPlaceholderExercise.JSONPlaceholder post = new JSONPlaceholderExercise.JSONPlaceholder();
            post.title = 'Updated Title';
            post.id = 1;
            posts.add(post);
        }
        
        // Act
        List<String> responses = JSONPlaceholderExercise.patchPostsTitle(posts);
        
        // Assert
        for(String response:responses){
            Assert.isNotNull(response, 'Response should not be null');
            Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(response);
            Assert.areEqual('Updated Title', responseMap.get('title'), 'Post title should be updated');
        }
    }
    
    @IsTest
    static void testDeletePosts() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new JSONPlaceholderMock(200, ''));
        List<Integer> postIds = new List<Integer>{1,2,3,4,5};
        
        // Act
        List<Integer> statusCodes = JSONPlaceholderExercise.deletePosts(postIds);

        for(Integer statusCode:statusCodes){
            // Assert
            Assert.areEqual(200, statusCode, 'Delete request should return status code 200');
        }
        
    }

    @IsTest
    static void testGetPostByIdException() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new JSONPlaceholderMock(400, ''));
        
        // Act
        try{
            JSONPlaceholderExercise.getPostById(1);
        }
        catch(JSONPlaceholderExercise.PostServiceException e){
            // Assert
            Assert.areEqual('Error', e.getMessage());
        }        
    }

    @IsTest
    static void testCreatePostException() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new JSONPlaceholderMock(400, ''));

        // Act
        try{
            JSONPlaceholderExercise.createPost('New Post', 'This is a new post', 1);
        }
        catch(JSONPlaceholderExercise.PostServiceException e){
            // Assert
            Assert.areEqual('Error', e.getMessage());
        }  
    }
    
    @IsTest
    static void testUpdatePostException() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new JSONPlaceholderMock(400, ''));

        // Act
        try{
            JSONPlaceholderExercise.updatePost(1, 'Updated Post', 'This is an updated post', 1);
        }
        catch(JSONPlaceholderExercise.PostServiceException e){
            // Assert
            Assert.areEqual('Error', e.getMessage());
        } 
    }
    
    @IsTest
    static void testPatchPostTitleException() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new JSONPlaceholderMock(400, ''));

        // Act
        try{
            JSONPlaceholderExercise.patchPostTitle(1, 'Updated Title');
        }
        catch(JSONPlaceholderExercise.PostServiceException e){
            // Assert
            Assert.areEqual('Error', e.getMessage());
        } 
    }
    
    @IsTest
    static void testDeletePostException() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new JSONPlaceholderMock(400, ''));

        // Act
        try{
            JSONPlaceholderExercise.deletePost(1);
        }
        catch(JSONPlaceholderExercise.PostServiceException e){
            // Assert
            Assert.areEqual('Error', e.getMessage());
        }
    }
} 
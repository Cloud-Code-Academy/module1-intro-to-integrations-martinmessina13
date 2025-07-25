@IsTest
public class JSONPlaceholderMock implements HttpCalloutMock {
    private Integer statusCode;
    private String responseBody;
    
    public JSONPlaceholderMock(Integer statusCode, String responseBody) {
        this.statusCode = statusCode;
        this.responseBody = responseBody;
    }
    
    public HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setStatusCode(this.statusCode);
        res.setBody(this.responseBody);
        res.setHeader('Content-Type', 'application/json');
        if(this.statusCode == 400){ // Added to unit test exceptions
            res.setStatus('Error');
        }
        return res;
    }
    
    // Helper method to create sample response for GET
    public static String getSampleGetResponse() {
        return '{'
            + '"userId": 1,'
            + '"id": 1,'
            + '"title": "Sample Post",'
            + '"body": "This is a sample post body"'
            + '}';
    }
    
    // Helper method to create sample response for POST
    public static String getSamplePostResponse() {
        return '{'
            + '"userId": 1,'
            + '"id": 101,'
            + '"title": "New Post",'
            + '"body": "This is a new post"'
            + '}';
    }
    
    // Helper method to create sample response for PUT
    public static String getSamplePutResponse() {
        return '{'
            + '"userId": 1,'
            + '"id": 1,'
            + '"title": "Updated Post",'
            + '"body": "This is an updated post"'
            + '}';
    }
    
    // Helper method to create sample response for PATCH
    public static String getSamplePatchResponse() {
        return '{'
            + '"userId": 1,'
            + '"id": 1,'
            + '"title": "Updated Title",'
            + '"body": "Original body remains unchanged"'
            + '}';
    }
}
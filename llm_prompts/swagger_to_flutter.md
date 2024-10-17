### Attachment:
Save Swagger doc as json or pdf

### Example Prompt:
#### Part 1:
```
Attached pdf file contains html page ,saved as pdf, with swagger documentation for api service 

Task: 
Based on it create api for flutter app, using Retrofit package For Dart

Requirements:
Give only code without key points, setup instructions, etc
Response model names must end with DTO (Example: ExampleResponseDTO)
Your answer will be split in two parts. First the API class. Second the models (I will request them manually after first your response)

Code for class:
@RestApi()
abstract class ExampleApi {
  factory ExampleApi(Dio dio) => _ExampleApi(dio, baseUrl: 'https://$serverUrl/example-api/');
}
```
#### Part 2:
```
Now continue with models

Requirements:
Models must be based on attached pdf file above and generated api class
Models must be created using @freezed
```
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:statusify/features/captions/domain/entities/openai_response.dart';

part 'openai_api.g.dart';

@RestApi(baseUrl: 'https://api.openai.com/v1')
abstract class OpenAiApi {
  factory OpenAiApi(Dio dio, {String baseUrl}) = _OpenAiApi;

  @POST('/responses')
  Future<OpenAiResponse> generateCaptions(@Body() Map<String, dynamic> body);
}

import "package:dio/dio.dart";
import "package:retrofit/retrofit.dart";
import "package:seed/features/assessment/domain/entities/question_dto.dart";

part "question_api.g.dart";

@RestApi()
abstract class QuestionApi {
  factory QuestionApi(Dio dio, {String baseUrl}) = _QuestionApi;

  @GET("/questions")
  Future<List<QuestionDto>> fetchQuestions(
      @Query("category") String category,
      @Query("difficulty") String difficulty
  );


}
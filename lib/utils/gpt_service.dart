import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class GptService {
  static const url = 'https://api.openai.com/v1/chat/completions';

  static Future<Map<String, dynamic>?> generateLesson(String content) async {
    final prompt = '''
당신은 Flutter 튜터입니다. 사용자가 입력한 내용을 바탕으로 핵심적인 내용을 뽑아 실제 실행 가능한 Flutter 코드로 구성된 문제를 JSON 형식으로 1개만 생성해줘.

조건:
- 줄 수는 10~12줄 사이의 실제 실행 가능한 코드로 구성
- 각 줄은 조립이 가능하도록 나누고
- 각 줄에 대한 간단한 설명도 꼭 포함
- 핵심적인 위젯 구조 위주로 생성
- 정답은 아래 JSON 형식으로만 출력
- 다른 설명 없이 순수 JSON만 반환
- correctSteps 리스트는 한 줄의 코드가 아니라, 문법 단위(키워드, 괄호, 문자열 등)로 잘게 쪼개서 구성
  예: ["void", "main", "(", ")", "{", "runApp", "(", "MyApp", "(", ")", ")", ";", "}"]

반드시 이 형식만 사용:
{
  "title": "문제 제목",
  "correctSteps": ["코드1", "코드2", "..."],
  "explanations": {
    "코드1": "해설",
    "코드2": "해설"
  }
}

학습 내용:
$content
''';
    final apiKey = dotenv.env['GPT_KEY']; // 🔐 GPT API 키 입력
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    final body = jsonEncode({
      'model': 'gpt-4o',
      'messages': [
        {'role': 'user', 'content': prompt},
      ],
      'temperature': 0.7,
    });

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print('🧠 GPT 응답 원문: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      final rawContent = data['choices'][0]['message']['content'];

      try {
        // GPT가 이상한 텍스트와 함께 응답하는 경우를 방지
        final startIndex = rawContent.indexOf('{');
        final endIndex = rawContent.lastIndexOf('}');
        final jsonOnly = rawContent.substring(startIndex, endIndex + 1);

        return json.decode(jsonOnly);
      } catch (e) {
        print('🚨 JSON 파싱 오류: $e');
      }
    } else {
      print('❌ GPT 응답 오류: ${response.statusCode}');
    }

    return null;
  }
}

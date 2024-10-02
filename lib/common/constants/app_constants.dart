String prefUserKey = 'user';
String prefTokenKey = 'token';
String prefRefreshTokenKey = 'refresh_token';

const String defaultAvatarUrl = 'https://feji.us/a593ri';

const String diaryTableName = 'Diary';

String movieRecomendationPrompt =
    r'Analyze the mood expressed in as less words as possible for the text given after the instructions and give a list of movies with atleast 5 movies in Pure JSON format so that I can use the response directly in a parser. The response must only contain a string of JSON like this example:{"mood": "mood", "movies": [{"name": "Name of movie","rating": "5/10","abstract": "Short teaser of the movie"}}. Text:';

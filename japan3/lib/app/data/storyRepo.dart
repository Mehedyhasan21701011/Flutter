import 'package:japan3/app/data/story.dart';

class StoryRepository {
  /// Demo data: Travel to Japan (anime-flavored) theme
  static List<StoryPart> loadParts() {
    return [
      // Part 0: Arrival in Tokyo
      StoryPart(
        id: 0,
        title: 'Arrival in Tokyo',
        text:
            'Kenji and Naya arrive at Tokyo Haneda Airport. The dazzling city, vending machines, and train-filled stations — everything is new to them.',
        imageUrl:
            'https://www.shutterstock.com/image-illustration/tokyo-international-airport-plane-landing-260nw-2634310779.jpg',
        question: 'Where did Kenji and Naya arrive?',
        options: [
          'Narita Airport',
          'Tokyo Haneda Airport',
          'Osaka Kansai Airport',
          'Kyoto Station',
        ],
        correctIndex: 1,
      ),

      // Part 1: Shibuya Crossing
      StoryPart(
        id: 1,
        title: 'Shibuya Crossing',
        text:
            'As they try to cross Shibuya’s massive crossing, they stop in awe — a flood of people. Naya says, “This city never sleeps!”',
        imageUrl:
            'https://ichef.bbci.co.uk/ace/standard/976/cpsprodpb/7A48/production/_108240313_gettyimages-514488672.jpg',
        question: 'Summarize the above passage in 8–12 words in English.',
        translationKeyword: 'people',
      ),

      // Part 2: Anime Café
      StoryPart(
        id: 2,
        title: 'Anime Café',
        text:
            'They step into an anime café. On the walls are their favorite characters, themed drinks — everything feels like a dream.',
        imageUrl:
            'https://www.shutterstock.com/image-vector/scene-social-distancing-cafeteria-people-600nw-1814392604.jpg',
        question: 'What kind of café did they visit?',
        options: [
          'Coffee shop',
          'Anime café',
          'Fast-food restaurant',
          'Tea house',
        ],
        correctIndex: 1,
      ),

      // Part 3: Cosplay and Temple Bells
      StoryPart(
        id: 3,
        title: 'Cosplay Adventure',
        text:
            'Kenji points to a corner where a group is cosplaying their favorite series, and Naya laughs in excitement. They take pictures, sip their drinks, and feel as if they’ve stepped into a world that is both familiar and magical. Time seems to slip away, and they realize this city, with its dazzling lights and endless energy, is unlike anything they’ve ever seen.',
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1640368262i/57475277.jpg',
        question: 'How did they feel about the city?',
        translationKeyword: 'familiar and magical',
      ),
    ];
  }
}
